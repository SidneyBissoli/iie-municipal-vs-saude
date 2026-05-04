#' build_synthesis_matrix.R
#'
#' Build the formatted XLSX version of the synthesis matrix for proposta v02
#' from the canonical CSV source. The CSV is the versioned source of truth;
#' the XLSX is a derivative for reading in Excel.
#'
#' Usage:
#'   source("R/build_synthesis_matrix.R")
#'   build_synthesis_matrix()
#'
#' Dependencies: openxlsx2, readr (or vroom), dplyr.
#' The function is idempotent: re-running overwrites the XLSX without warning.

build_synthesis_matrix <- function(
  csv_path  = "assets/synthesis_matrix_proposta_v02.csv",
  xlsx_path = "assets/synthesis_matrix_proposta_v02.xlsx"
) {

  # --- Load packages (fail fast if missing) ---------------------------------
  required_pkgs <- c("openxlsx2", "readr", "dplyr")
  missing_pkgs  <- required_pkgs[!vapply(required_pkgs, requireNamespace,
                                         logical(1), quietly = TRUE)]
  if (length(missing_pkgs) > 0L) {
    stop("Missing packages: ", paste(missing_pkgs, collapse = ", "),
         ". Install with install.packages() then re-run.", call. = FALSE)
  }

  # --- Read CSV (Brazilian convention: ; separator, "" escape, UTF-8 BOM) ---
  matrix_df <- readr::read_csv2(
    csv_path,
    locale       = readr::locale(encoding = "UTF-8", decimal_mark = ","),
    show_col_types = FALSE
  )

  # --- Validate column structure --------------------------------------------
  expected_cols <- c(
    "chave_bibtex", "autores", "ano", "objeto", "metodo",
    "achado_principal", "corrente_teorica", "trecho_verbatim", "pagina",
    "tag_tema", "tipo_publicacao", "risco_verificacao"
  )
  if (!identical(colnames(matrix_df), expected_cols)) {
    stop("CSV columns do not match expected schema. Got: ",
         paste(colnames(matrix_df), collapse = ", "), call. = FALSE)
  }

  # --- Pre-compute per-row visual cues --------------------------------------
  # Group-alternating background tone by tag_tema (one tone per thematic block)
  unique_themes <- unique(matrix_df$tag_tema)
  theme_index   <- match(matrix_df$tag_tema, unique_themes)
  fill_palette  <- c("FFFFFF", "F2F2F2")  # white and light grey
  row_fills     <- fill_palette[(theme_index %% 2L) + 1L]

  # Risk-cell color (column risco_verificacao)
  risk_palette  <- c(B = "C6EFCE", M = "FFEB9C", A = "FFC7CE")
  risk_fills    <- risk_palette[matrix_df$risco_verificacao]
  risk_fills[is.na(risk_fills)] <- "FFFFFF"

  # --- Build workbook -------------------------------------------------------
  wb <- openxlsx2::wb_workbook(creator = "iie-municipal-vs-saude project")
  wb$add_worksheet(sheet = "synthesis_matrix")

  # Write data starting at row 1
  wb$add_data(sheet = "synthesis_matrix", x = matrix_df, start_row = 1L)

  n_rows <- nrow(matrix_df)
  n_cols <- ncol(matrix_df)

  # Header formatting: bold, white text, dark fill
  wb$add_fill(sheet = "synthesis_matrix",
              dims  = openxlsx2::wb_dims(rows = 1L, cols = 1L:n_cols),
              color = openxlsx2::wb_color(hex = "1F4E78"))
  wb$add_font(sheet = "synthesis_matrix",
              dims  = openxlsx2::wb_dims(rows = 1L, cols = 1L:n_cols),
              bold  = "true",
              color = openxlsx2::wb_color(hex = "FFFFFF"))

  # Body row formatting: alternating fills by thematic group, wrap text
  for (i in seq_len(n_rows)) {
    row_in_sheet <- i + 1L  # offset by 1 for header
    wb$add_fill(
      sheet = "synthesis_matrix",
      dims  = openxlsx2::wb_dims(rows = row_in_sheet, cols = 1L:n_cols),
      color = openxlsx2::wb_color(hex = row_fills[i])
    )
    # Risk column gets its own fill (overrides the row fill)
    risk_col_idx <- which(expected_cols == "risco_verificacao")
    wb$add_fill(
      sheet = "synthesis_matrix",
      dims  = openxlsx2::wb_dims(rows = row_in_sheet, cols = risk_col_idx),
      color = openxlsx2::wb_color(hex = risk_fills[i])
    )
  }

  # Wrap text in long-prose columns
  wrap_cols <- which(expected_cols %in% c(
    "autores", "objeto", "metodo", "achado_principal",
    "corrente_teorica", "trecho_verbatim"
  ))
  for (col_idx in wrap_cols) {
    wb$add_cell_style(
      sheet      = "synthesis_matrix",
      dims       = openxlsx2::wb_dims(rows = 2L:(n_rows + 1L), cols = col_idx),
      wrap_text  = "true",
      vertical   = "top"
    )
  }

  # Column widths (manual tuning for readability)
  col_widths <- c(
    chave_bibtex      = 38,
    autores           = 35,
    ano               =  6,
    objeto            = 50,
    metodo            = 45,
    achado_principal  = 55,
    corrente_teorica  = 35,
    trecho_verbatim   = 60,
    pagina            = 14,
    tag_tema          = 28,
    tipo_publicacao   = 10,
    risco_verificacao =  8
  )
  wb$set_col_widths(
    sheet = "synthesis_matrix",
    cols  = seq_len(n_cols),
    widths = col_widths[expected_cols]
  )

  # Freeze top row + first column; enable autofilter on header
  wb$freeze_pane(sheet = "synthesis_matrix",
                 first_active_row = 2L, first_active_col = 2L)
  wb$add_filter(sheet = "synthesis_matrix",
                rows = 1L, cols = 1L:n_cols)

  # Save
  openxlsx2::wb_save(wb, file = xlsx_path, overwrite = TRUE)

  message("Synthesis matrix XLSX written to: ", xlsx_path,
          " (", n_rows, " entries)")

  invisible(xlsx_path)
}
