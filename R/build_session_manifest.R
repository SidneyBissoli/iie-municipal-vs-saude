# Generate a Claude Code session manifest at end-of-session. The manifest
# anchors reproducibility between sessions: the next session begins by
# verifying it (see `R/verify_session_manifest.R`), and any divergence
# halts work until investigated. See CLAUDE.md §7 and roadmap §T.6.

#' Build a session manifest and write it to `.claude/sessao-NNN-manifest.json`.
#'
#' @param session_id Three-character zero-padded id (e.g. `"001"`).
#' @param artifacts  Character vector of file paths (relative to the project
#'   root) produced or modified during the session.
#' @param contracts  Optional named list mapping each artefact path to a
#'   contract function (`R/contracts.R`). When provided, `pointblank` runs
#'   immediately and the manifest records `pass`/`fail`/`warn`. Paths
#'   without a contract get `n/a`.
#' @param manifest_dir Output dir (default `".claude"`).
#' @return (Invisibly) the manifest as a list.
build_session_manifest <- function(session_id,
                                   artifacts,
                                   contracts = NULL,
                                   manifest_dir = ".claude") {
  stopifnot(
    is.character(session_id),
    nchar(session_id) > 0L,
    is.character(artifacts),
    is.null(contracts) || is.list(contracts)
  )

  if (!dir.exists(manifest_dir)) {
    dir.create(manifest_dir, recursive = TRUE)
  }

  records <- lapply(artifacts, function(p) build_artifact_record(p, contracts))

  manifest <- list(
    session_id = session_id,
    timestamp = format(
      Sys.time(),
      format = "%Y-%m-%dT%H:%M:%S%z",
      tz = "UTC"
    ),
    commit_sha = git_head_sha(),
    renv_lockfile_sha256 = if (file.exists("renv.lock")) {
      sha256_file("renv.lock")
    } else {
      NA_character_
    },
    r_version = R.version.string,
    artifacts = records
  )

  out_path <- file.path(
    manifest_dir,
    sprintf("sessao-%s-manifest.json", session_id)
  )

  jsonlite::write_json(
    manifest,
    out_path,
    auto_unbox = TRUE,
    pretty     = TRUE,
    null       = "null"
  )

  message(sprintf("Wrote manifest: %s", out_path))
  invisible(manifest)
}

# ---- helpers --------------------------------------------------------------

#' Build one `{path, sha256, status, size}` record.
build_artifact_record <- function(path, contracts) {
  if (!file.exists(path)) {
    return(list(
      path              = path,
      sha256            = NA_character_,
      pointblank_status = "missing",
      size_bytes        = NA_integer_
    ))
  }

  status <- "n/a"
  if (!is.null(contracts) && path %in% names(contracts)) {
    status <- run_contract_status(path, contracts[[path]])
  }

  list(
    path              = path,
    sha256            = sha256_file(path),
    pointblank_status = status,
    size_bytes        = unname(file.info(path)$size)
  )
}

#' Run a contract for an artefact path and return one of `pass`, `fail`,
#' `warn`, or `n/a`. Reads parquet or csv via arrow/readr; other formats
#' return `n/a` (no contract applicable).
run_contract_status <- function(path, contract) {
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

#' SHA-256 of a file's contents.
sha256_file <- function(path) {
  digest::digest(file = path, algo = "sha256")
}

#' Current git HEAD short SHA, or `NA` if not in a git repo.
git_head_sha <- function() {
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
