# Write a derived data frame to disk only after a `pointblank` contract
# passes. Halts the pipeline on contract failure: failures are bugs, not
# warnings.
#
# Usage:
#   write_with_contract(
#     df       = obitos_mun_ano_causa,
#     contract = obitos_mun_ano_causa_contract,
#     path     = "data/obitos_mun_ano_causa.parquet"
#   )

#' Validate a data frame against a contract and persist as Parquet.
#'
#' @param df       Data frame (or tibble) to validate and write.
#' @param contract Function that accepts `df` and returns a
#'   `pointblank::create_agent()` object configured with validation steps,
#'   *not yet* interrogated.
#' @param path     Destination path. Parent directory is created if missing.
#' @param fmt      Output format: `"parquet"` (default) or `"qs2"` for
#'   on-disk caching of complex R objects.
#' @return (Invisibly) the interrogated agent on success.
#' @importFrom pointblank interrogate all_passed get_agent_report
#' @importFrom arrow write_parquet
write_with_contract <- function(df, contract, path, fmt = c("parquet", "qs2")) {
  fmt <- match.arg(fmt)
  stopifnot(
    is.data.frame(df),
    is.function(contract),
    is.character(path),
    length(path) == 1L
  )

  agent <- contract(df)
  if (!inherits(agent, "ptblank_agent")) {
    stop(
      "`contract()` must return a `pointblank` agent object ",
      "(use `pointblank::create_agent(df) |> col_*() |> rows_*()`).",
      call. = FALSE
    )
  }

  agent <- pointblank::interrogate(agent)

  if (!pointblank::all_passed(agent)) {
    report <- utils::capture.output(print(agent))
    stop(
      sprintf(
        "Contract failed for `%s`. Halting before write.\n%s",
        path,
        paste(report, collapse = "\n")
      ),
      call. = FALSE
    )
  }

  parent <- dirname(path)
  if (!dir.exists(parent)) {
    dir.create(parent, recursive = TRUE)
  }

  if (fmt == "parquet") {
    arrow::write_parquet(df, path)
  } else {
    qs2::qs_save(df, path)
  }

  invisible(agent)
}
