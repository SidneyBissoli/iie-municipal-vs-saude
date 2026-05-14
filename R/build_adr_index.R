# Build ADR and REV indexes by scanning `decisions/` and rewriting the two
# auto-generated tables in `decisions/README.md`.
#
# Both ADRs (`ADR-NNN-*.md`) and REVs (`REV-MNN.md`) live in the same folder
# and share YAML frontmatter; one scanner handles both. Indexes are written
# between sentinel comments so manual prose around them stays untouched.

#' Build ADR + REV index in `decisions/README.md`.
#'
#' Scans `decisions/` for `ADR-*.md` and `REV-*.md` files, parses YAML
#' frontmatter, and writes two tables into `decisions/README.md` between the
#' `BEGIN: ADR_INDEX` / `END: ADR_INDEX` and `BEGIN: REV_INDEX` /
#' `END: REV_INDEX` sentinels.
#'
#' @param decisions_dir Path to the decisions directory.
#' @param readme_path   Path to the readme to update.
#' @return (Invisibly) a list with the parsed `adrs` and `revs` data frames.
build_adr_index <- function(decisions_dir = "decisions",
                            readme_path = "decisions/README.md") {
  stopifnot(dir.exists(decisions_dir), file.exists(readme_path))

  files <- list.files(
    decisions_dir,
    pattern = "^(ADR|REV)-.*\\.md$",
    full.names = TRUE
  )
  files <- files[!grepl("_template", files)]

  records <- lapply(files, parse_decision_frontmatter)
  records <- Filter(Negate(is.null), records)

  adrs <- records[vapply(records, function(x) x$kind == "ADR", logical(1))]
  revs <- records[vapply(records, function(x) x$kind == "REV", logical(1))]

  adrs <- sort_records(adrs, key = "id")
  revs <- sort_records(revs, key = "id")

  adr_table <- render_adr_table(adrs)
  rev_table <- render_rev_table(revs)

  readme <- readLines(readme_path, warn = FALSE)
  readme <- replace_block(readme, "ADR_INDEX", adr_table)
  readme <- replace_block(readme, "REV_INDEX", rev_table)
  writeLines(readme, readme_path)

  invisible(list(adrs = adrs, revs = revs))
}

#' Parse YAML frontmatter from a single decision file.
#' @param path File path.
#' @return A list of fields, or `NULL` if no frontmatter is found.
#' @noRd
parse_decision_frontmatter <- function(path) {
  lines <- readLines(path, warn = FALSE)
  if (length(lines) < 3 || lines[[1]] != "---") {
    return(NULL)
  }
  end_idx <- which(lines == "---")[2]
  if (is.na(end_idx)) {
    return(NULL)
  }
  yaml_lines <- lines[2:(end_idx - 1)]
  meta <- parse_simple_yaml(yaml_lines)

  meta$kind <- if (grepl("^ADR-", basename(path))) "ADR" else "REV"
  meta$path <- path
  meta
}

#' Minimal YAML parser for the limited subset used in decision frontmatter
#' (flat `key: value` lines, optional comments, no nested structures).
#' Avoids a hard dependency on the `yaml` package for this small task.
#' @noRd
parse_simple_yaml <- function(lines) {
  lines <- lines[!grepl("^\\s*#", lines)]
  lines <- lines[nzchar(trimws(lines))]
  pairs <- regmatches(
    lines,
    regexec("^([A-Za-z_][A-Za-z0-9_]*)\\s*:\\s*(.*)$", lines)
  )
  out <- list()
  for (m in pairs) {
    if (length(m) == 3) {
      key <- m[2]
      val <- trimws(sub("\\s+#.*$", "", m[3]))
      val <- gsub("^['\"]|['\"]$", "", val)
      out[[key]] <- val
    }
  }
  out
}

#' Sort records by a frontmatter key, preserving non-matching entries last.
#' @noRd
sort_records <- function(records, key) {
  if (length(records) == 0) {
    return(records)
  }
  ord <- order(vapply(records, function(x) x[[key]] %||% "", character(1)))
  records[ord]
}

#' Render the ADR table as Markdown rows.
#' @noRd
render_adr_table <- function(adrs) {
  header <- c(
    "| ID | Título | Status | Item do roadmap | Data |",
    "|---|---|---|---|---|"
  )
  if (length(adrs) == 0) {
    return(c(header, "| _(nenhum ADR registrado ainda)_ | | | | |"))
  }
  rows <- vapply(adrs, function(x) {
    sprintf(
      "| [%s](%s) | %s | %s | %s | %s |",
      x$id %||% "?",
      basename(x$path),
      x$title %||% "?",
      x$status %||% "?",
      x$roadmap_ref %||% "?",
      x$date %||% "?"
    )
  }, character(1))
  c(header, rows)
}

#' Render the REV table as Markdown rows.
#' @noRd
render_rev_table <- function(revs) {
  header <- c(
    "| ID | Título | Status | Fase | Data |",
    "|---|---|---|---|---|"
  )
  if (length(revs) == 0) {
    return(c(header, "| _(nenhuma REV registrada ainda)_ | | | | |"))
  }
  rows <- vapply(revs, function(x) {
    sprintf(
      "| [%s](%s) | %s | %s | %s | %s |",
      x$id %||% "?",
      basename(x$path),
      x$title %||% "?",
      x$status %||% "?",
      x$phase_ref %||% "?",
      x$date %||% "?"
    )
  }, character(1))
  c(header, rows)
}

#' Replace a block delimited by `<!-- BEGIN: TAG -->` / `<!-- END: TAG -->`
#' sentinels in a character vector of file lines.
#' @noRd
replace_block <- function(lines, tag, content) {
  begin <- which(grepl(sprintf("BEGIN:\\s*%s", tag), lines))
  end <- which(grepl(sprintf("END:\\s*%s", tag), lines))
  if (length(begin) != 1L || length(end) != 1L || end <= begin) {
    stop(sprintf("Sentinels for tag '%s' not found in target file.", tag))
  }
  c(
    lines[seq_len(begin)],
    "",
    content,
    "",
    lines[end:length(lines)]
  )
}

# Fallback `%||%` only when running on R < 4.4. From 4.4 onward it is in base.
if (!exists("%||%", mode = "function", envir = baseenv())) {
  `%||%` <- function(a, b) {
    if (is.null(a) || is.na(a) || !nzchar(a)) b else a
  }
}
