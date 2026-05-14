# Build the bibliography index by parsing `references.bib` and crossing it
# with reading-list metadata, the `notes/` folder and the `md-resumos/`
# folder. Updates the auto-block in `bibliography/README.md`.

#' Build bibliography index in `bibliography/README.md`.
#'
#' Parses citation keys, titles and entry types from `references.bib`,
#' looks up `status` and `role` for each key in `reading-list.md` (when the
#' user populates it), checks whether a per-note file exists in `notes/`,
#' and checks whether a narrative summary exists in `md-resumos/`. Notes
#' are matched by exact citation key (filename = `<key>.md`); md-resumos
#' use the convention `<Author[ETAL]>_<YYYY>_<slug>.md` and are matched
#' by case-insensitive `<author><year>` prefix against the citation key.
#'
#' @param bib_dir        Path to the bibliography directory.
#' @param bib_path       Path to the `.bib` file.
#' @param list_path      Path to the reading list.
#' @param notes_dir      Path to the per-note folder.
#' @param md_resumos_dir Path to the narrative-summary folder.
#' @param readme         Path to the README to update.
#' @return (Invisibly) the parsed entries data frame.
build_bibliography_index <- function(
  bib_dir = "bibliography",
  bib_path = file.path(bib_dir, "references.bib"),
  list_path = file.path(bib_dir, "reading-list.md"),
  notes_dir = file.path(bib_dir, "notes"),
  md_resumos_dir = file.path(bib_dir, "md-resumos"),
  readme = file.path(bib_dir, "README.md")
) {
  stopifnot(file.exists(bib_path), file.exists(readme))

  entries <- parse_bib_entries(bib_path)
  metadata <- parse_reading_list(list_path)
  resumo_prefixes <- collect_md_resumo_prefixes(md_resumos_dir)

  header <- c(
    "| Chave | Título curto | Status | Papel | Tem nota? | Tem resumo? |",
    "|---|---|:-:|---|:-:|:-:|"
  )

  if (length(entries) == 0L) {
    table_lines <- c(
      header,
      "| _(references.bib ainda vazio; ver bootstrap em README)_ | | | | | |"
    )
  } else {
    rows <- vapply(entries, function(e) {
      meta <- metadata[[e$key]] %||% list(status = "?", role = "?")
      note_path <- file.path(notes_dir, paste0(e$key, ".md"))
      has_note <- if (file.exists(note_path)) "✓" else "—"
      has_resumo <- if (key_has_md_resumo(e$key, resumo_prefixes)) "✓" else "—"
      sprintf(
        "| `%s` | %s | %s | %s | %s | %s |",
        e$key,
        truncate_str(e$title, 60),
        meta$status,
        meta$role,
        has_note,
        has_resumo
      )
    }, character(1))
    table_lines <- c(header, rows)
  }

  lines <- readLines(readme, warn = FALSE)
  lines <- replace_block(lines, "BIB_INDEX", table_lines)
  writeLines(lines, readme)

  invisible(entries)
}

#' Collect lowercase `<author><year>` prefixes from `md-resumos/` filenames.
#' Filenames follow `<Author[ETAL]>_<YYYY>_<slug>.md`. Returns `character(0)`
#' if the folder is missing. Skips template and README files.
collect_md_resumo_prefixes <- function(md_resumos_dir) {
  if (!dir.exists(md_resumos_dir)) {
    return(character())
  }
  files <- list.files(md_resumos_dir, pattern = "\\.md$", full.names = FALSE)
  files <- setdiff(files, c("README.md", "_resumo-template.md"))
  parts <- regmatches(files, regexec("^([^_]+)_(\\d{4})_.*\\.md$", files))
  prefixes <- vapply(parts, function(x) {
    if (length(x) < 3L) {
      return(NA_character_)
    }
    paste0(tolower(x[[2]]), x[[3]])
  }, character(1))
  prefixes[!is.na(prefixes)]
}

#' Whether a citation key matches any md-resumo prefix collected above.
key_has_md_resumo <- function(key, prefixes) {
  if (length(prefixes) == 0L) {
    return(FALSE)
  }
  any(startsWith(key, prefixes))
}

#' Parse a (subset of) BibTeX into a list of `{key, type, title}` records.
#' Tolerant of comments at the top of the file.
parse_bib_entries <- function(path) {
  txt <- paste(readLines(path, warn = FALSE), collapse = "\n")
  txt <- gsub("(?m)^%.*$", "", txt, perl = TRUE)

  matches <- gregexpr(
    "@(\\w+)\\s*\\{\\s*([^,]+),",
    txt,
    perl = TRUE
  )[[1]]
  if (matches[[1]] == -1L) {
    return(list())
  }
  hits <- regmatches(txt, gregexpr(
    "@(\\w+)\\s*\\{\\s*([^,]+),",
    txt,
    perl = TRUE
  ))[[1]]

  entries <- lapply(hits, function(h) {
    type_key <- regmatches(h, regexec("@(\\w+)\\s*\\{\\s*([^,]+),", h))[[1]]
    list(type = trimws(type_key[2]), key = trimws(type_key[3]))
  })

  for (i in seq_along(entries)) {
    entries[[i]]$title <- extract_field(txt, entries[[i]]$key, "title")
  }
  entries
}

#' Extract a BibTeX field value for a given citation key. Naive: looks for
#' the next `field = {...}` block following the key in the source text.
extract_field <- function(txt, key, field) {
  pat <- sprintf(
    "@\\w+\\s*\\{\\s*%s,[\\s\\S]*?%s\\s*=\\s*[\\{\"]([^\\}\"]+)[\\}\"]",
    gsub("([\\^$.|?*+()\\[\\]])", "\\\\\\1", key, perl = TRUE),
    field
  )
  m <- regmatches(txt, regexec(pat, txt, perl = TRUE))
  if (length(m) == 0 || length(m[[1]]) < 2) "" else trimws(m[[1]][2])
}

#' Parse the `| key | ... | status | ... |` table in reading-list.md into a
#' named list keyed by citation key. Tolerant of empty tables.
parse_reading_list <- function(path) {
  if (!file.exists(path)) {
    return(list())
  }
  lines <- readLines(path, warn = FALSE)
  rows <- lines[grepl("^\\|", lines) & !grepl("^\\|[-\\s|:]+\\|$", lines)]
  if (length(rows) <= 1L) {
    return(list())
  }
  rows <- rows[-1L]

  out <- list()
  for (r in rows) {
    cells <- trimws(strsplit(r, "\\|", fixed = FALSE)[[1]])
    cells <- cells[nzchar(cells)]
    if (length(cells) < 4L) next
    key <- gsub("^`|`$", "", cells[[1]])
    out[[key]] <- list(
      title = cells[[2]],
      status = cells[[3]],
      role = cells[[4]]
    )
  }
  out
}

truncate_str <- function(x, n) {
  if (is.null(x) || !nzchar(x)) {
    return("?")
  }
  if (nchar(x) <= n) x else paste0(substr(x, 1, n - 1), "…")
}

# `replace_block()` is defined in `R/build_adr_index.R`; ensure this file is
# sourced together with that one so the helper is available at call time.
if (!exists("replace_block", mode = "function")) {
  source(file.path("R", "build_adr_index.R"))
}
replace_block <- get("replace_block", mode = "function")
