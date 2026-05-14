# Verify the most recent Claude Code session manifest. Run this at the
# start of every Code session: if the report is not `pass`, halt work
# until the divergence is explained (see CLAUDE.md §7).

#' Verify the most recent session manifest in `.claude/`.
#'
#' For each artefact listed in the latest `sessao-NNN-manifest.json`:
#' (1) re-hash file contents, (2) re-run the contract (when provided),
#' (3) check the recorded commit SHA matches `git rev-parse HEAD`.
#'
#' @param manifest_dir Directory holding manifests (default `".claude"`).
#' @param contracts    Optional named list of contracts to re-run, keyed by
#'   artefact path. If `NULL`, only hash + commit checks are performed.
#' @param strict       If `TRUE` (default), throws on any divergence; if
#'   `FALSE`, returns the report so the caller can decide.
#' @return A list with `status` (`"pass"` | `"fail"` | `"empty"`),
#'   `manifest_path`, and `details` per artefact.
verify_last_session_manifest <- function(manifest_dir = ".claude",
                                         contracts = NULL,
                                         strict = TRUE) {
  empty_report <- list(
    status = "empty",
    manifest_path = NA_character_,
    details = list()
  )
  if (!dir.exists(manifest_dir)) {
    return(empty_report)
  }

  files <- list.files(
    manifest_dir,
    pattern = "^sessao-.*-manifest\\.json$",
    full.names = TRUE
  )
  if (length(files) == 0L) {
    return(empty_report)
  }

  latest <- files[order(files, decreasing = TRUE)][[1]]
  manifest <- jsonlite::read_json(latest, simplifyVector = FALSE)

  details <- lapply(manifest$artifacts, function(a) verify_one(a, contracts))

  current_sha <- git_head_sha_local()
  commit_match <- identical(current_sha, manifest$commit_sha) ||
    is.na(current_sha) || is.na(manifest$commit_sha)

  any_fail <- any(vapply(details, function(d) d$status != "pass", logical(1)))
  status <- if (any_fail || !commit_match) "fail" else "pass"

  report <- list(
    status = status,
    manifest_path = latest,
    session_id = manifest$session_id,
    timestamp = manifest$timestamp,
    commit_recorded = manifest$commit_sha,
    commit_current = current_sha,
    commit_match = commit_match,
    details = details
  )

  if (strict && status != "pass") {
    msg <- format_failure_report(report)
    stop(msg, call. = FALSE)
  }

  message(sprintf(
    "verify_last_session_manifest: %s (%s)",
    toupper(status),
    basename(latest)
  ))
  invisible(report)
}

# ---- helpers --------------------------------------------------------------

#' @noRd
verify_one <- function(record, contracts) {
  path <- record$path
  if (!file.exists(path)) {
    return(list(
      path = path,
      status = "missing",
      expected = record$sha256,
      actual = NA
    ))
  }
  actual <- digest::digest(file = path, algo = "sha256")
  hash_ok <- identical(actual, record$sha256)

  contract_status <- "n/a"
  if (!is.null(contracts) && path %in% names(contracts)) {
    contract_status <- rerun_contract(path, contracts[[path]])
  }

  status <- if (!hash_ok || contract_status == "fail") {
    "fail"
  } else if (contract_status == "warn") {
    "warn"
  } else {
    "pass"
  }
  list(
    path = path,
    status = status,
    expected = record$sha256,
    actual = actual,
    contract_status_recorded = record$pointblank_status,
    contract_status_now = contract_status
  )
}

#' @noRd
rerun_contract <- function(path, contract) {
  ext <- tolower(tools::file_ext(path))
  df <- tryCatch(
    {
      if (ext == "parquet") {
        arrow::read_parquet(path)
      } else if (ext == "csv") {
        readr::read_csv(path, show_col_types = FALSE)
      } else {
        return("n/a")
      }
    },
    error = function(e) e
  )
  if (inherits(df, "error")) {
    return("warn")
  }

  agent <- tryCatch(
    pointblank::interrogate(contract(df)),
    error = function(e) e
  )
  if (inherits(agent, "error")) {
    return("fail")
  }
  if (pointblank::all_passed(agent)) "pass" else "fail"
}

#' @noRd
git_head_sha_local <- function() {
  out <- tryCatch(
    suppressWarnings(system2(
      "git",
      args = c("rev-parse", "HEAD"),
      stdout = TRUE,
      stderr = FALSE
    )),
    error = function(e) NA_character_
  )
  if (length(out) == 0L || !nzchar(out[[1]])) NA_character_ else out[[1]]
}

#' @noRd
format_failure_report <- function(report) {
  bad <- vapply(report$details, function(d) d$status != "pass", logical(1))
  bad_paths <- vapply(report$details[bad], function(d) d$path, character(1))
  commit_msg <- if (!report$commit_match) {
    sprintf(
      "Commit mismatch: manifest=%s, current=%s.",
      report$commit_recorded %||% "<NA>",
      report$commit_current %||% "<NA>"
    )
  } else {
    ""
  }
  paste0(
    "Session manifest verification FAILED.\n",
    sprintf("Manifest: %s\n", report$manifest_path),
    if (nzchar(commit_msg)) paste0(commit_msg, "\n") else "",
    "Divergent artefacts:\n  - ",
    paste(bad_paths, collapse = "\n  - "),
    "\nResolve before starting new work (see CLAUDE.md §7)."
  )
}

# `%||%` is in base R from 4.4 onward; older R falls back to the helper in
# `R/build_adr_index.R`.
