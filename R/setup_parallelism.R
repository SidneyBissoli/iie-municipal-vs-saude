# Configure parallel-execution backends for the pipeline. Called once at
# the top of `_targets.R` so that downstream targets that wrap
# `microdatasus::fetch_datasus()` honour `future::plan()` and so that
# `data.table` aggregations do not over-subscribe CPU when concurrent
# `future` workers are also running. See CLAUDE.md §10 and roadmap-v02
# §0.4.

#' Resolve effective parallelism settings without applying side effects.
#'
#' Pure helper extracted for testability — no `future::plan()` is invoked,
#' no DT threads are mutated. Resolution priority for each setting:
#' explicit argument > env var override > CI clamp > detected default.
#'
#' @param workers        Integer or `NULL`. Explicit override.
#' @param dt_threads     Integer or `NULL`. Explicit override.
#' @param ci_mode        Logical. When `TRUE`, both settings clamp to 2
#'   regardless of `n_cores` (CI runners have ≤4 vCPUs and OOM easily).
#' @param n_cores        Integer. Detected logical cores.
#' @param env_workers    Character. Value of `IIE_PARALLEL_WORKERS` env
#'   var ("" if unset).
#' @param env_dt_threads Character. Value of `IIE_DT_THREADS` env var
#'   ("" if unset).
#' @return Named list `list(workers, dt_threads, ci_mode, n_cores)` with
#'   resolved integer values.
resolve_parallelism_settings <- function(workers,
                                         dt_threads,
                                         ci_mode,
                                         n_cores,
                                         env_workers,
                                         env_dt_threads) {
  stopifnot(
    is.null(workers) || is.numeric(workers),
    is.null(dt_threads) || is.numeric(dt_threads),
    is.logical(ci_mode), length(ci_mode) == 1L,
    is.numeric(n_cores), length(n_cores) == 1L,
    is.character(env_workers), length(env_workers) == 1L,
    is.character(env_dt_threads), length(env_dt_threads) == 1L
  )

  n_cores <- as.integer(n_cores)
  if (is.na(n_cores) || n_cores < 1L) n_cores <- 1L

  resolved_workers <- resolve_one(
    explicit = workers,
    env_value = env_workers,
    ci_value = 2L,
    ci_mode = ci_mode,
    default_fn = function() min(16L, max(1L, n_cores - 2L))
  )

  resolved_dt_threads <- resolve_one(
    explicit = dt_threads,
    env_value = env_dt_threads,
    ci_value = 2L,
    ci_mode = ci_mode,
    default_fn = function() max(1L, n_cores %/% 2L)
  )

  list(
    workers = resolved_workers,
    dt_threads = resolved_dt_threads,
    ci_mode = ci_mode,
    n_cores = n_cores
  )
}

#' Resolve a single integer setting from the priority chain.
resolve_one <- function(explicit, env_value, ci_value, ci_mode, default_fn) {
  if (!is.null(explicit)) {
    return(max(1L, as.integer(explicit)))
  }
  if (nzchar(env_value)) {
    parsed <- suppressWarnings(as.integer(env_value))
    if (!is.na(parsed) && parsed >= 1L) {
      return(parsed)
    }
  }
  if (isTRUE(ci_mode)) {
    return(as.integer(ci_value))
  }
  as.integer(default_fn())
}

#' Configure `future` and `data.table` parallel backends.
#'
#' Side effects: calls `future::plan(future::multisession, workers = ...)`
#' (only if the `future` package is installed) and
#' `data.table::setDTthreads(...)`. Designed to be called once at the top
#' of `_targets.R`.
#'
#' @param workers     Optional explicit worker count for `future::plan()`.
#'   When `NULL` (default), resolved via env var / CI clamp / detected
#'   default — see [resolve_parallelism_settings()].
#' @param dt_threads  Optional explicit thread count for
#'   `data.table::setDTthreads()`. Same resolution chain as `workers`.
#' @return (Invisibly) a named list with the values actually applied,
#'   plus `plan` ("multisession" or "sequential") indicating the backend
#'   that was set.
setup_parallelism <- function(workers = NULL, dt_threads = NULL) {
  ci_mode <- identical(
    tolower(Sys.getenv("TARGETS_CI_SMOKE")),
    "true"
  )

  settings <- resolve_parallelism_settings(
    workers = workers,
    dt_threads = dt_threads,
    ci_mode = ci_mode,
    n_cores = parallel::detectCores(logical = TRUE),
    env_workers = Sys.getenv("IIE_PARALLEL_WORKERS"),
    env_dt_threads = Sys.getenv("IIE_DT_THREADS")
  )

  data.table::setDTthreads(settings$dt_threads)

  if (requireNamespace("future", quietly = TRUE)) {
    future::plan(future::multisession, workers = settings$workers)
    settings$plan <- "multisession"
  } else {
    message(
      "Package `future` not installed; skipping `future::plan()`. ",
      "Install `future` to enable `microdatasus` parallelism."
    )
    settings$plan <- "sequential"
  }

  invisible(settings)
}
