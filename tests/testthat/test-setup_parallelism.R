test_that("resolve_parallelism_settings: defaults from detected cores", {
  out <- resolve_parallelism_settings(
    workers = NULL,
    dt_threads = NULL,
    ci_mode = FALSE,
    n_cores = 20L,
    env_workers = "",
    env_dt_threads = ""
  )
  expect_equal(out$workers, 16L) # min(16, 20-2) = 16
  expect_equal(out$dt_threads, 10L) # 20 %/% 2 = 10
  expect_false(out$ci_mode)
  expect_equal(out$n_cores, 20L)
})

test_that("resolve_parallelism_settings: workers caps at 16 even on big iron", {
  out <- resolve_parallelism_settings(
    workers = NULL, dt_threads = NULL, ci_mode = FALSE,
    n_cores = 64L, env_workers = "", env_dt_threads = ""
  )
  expect_equal(out$workers, 16L)
  expect_equal(out$dt_threads, 32L)
})

test_that("resolve_parallelism_settings: workers floor is 1 on tiny boxes", {
  out <- resolve_parallelism_settings(
    workers = NULL, dt_threads = NULL, ci_mode = FALSE,
    n_cores = 2L, env_workers = "", env_dt_threads = ""
  )
  expect_equal(out$workers, 1L) # max(1, 2-2) = 1
  expect_equal(out$dt_threads, 1L) # max(1, 2 %/% 2) = 1
})

test_that("resolve_parallelism_settings: CI mode clamps to 2", {
  out <- resolve_parallelism_settings(
    workers = NULL, dt_threads = NULL, ci_mode = TRUE,
    n_cores = 20L, env_workers = "", env_dt_threads = ""
  )
  expect_equal(out$workers, 2L)
  expect_equal(out$dt_threads, 2L)
  expect_true(out$ci_mode)
})

test_that("resolve_parallelism_settings: env vars override defaults and CI", {
  out <- resolve_parallelism_settings(
    workers = NULL, dt_threads = NULL, ci_mode = TRUE,
    n_cores = 20L, env_workers = "8", env_dt_threads = "4"
  )
  # Env vars beat the CI clamp.
  expect_equal(out$workers, 8L)
  expect_equal(out$dt_threads, 4L)
})

test_that("resolve_parallelism_settings: explicit args beat env vars", {
  out <- resolve_parallelism_settings(
    workers = 6, dt_threads = 3, ci_mode = TRUE,
    n_cores = 20L, env_workers = "8", env_dt_threads = "4"
  )
  expect_equal(out$workers, 6L)
  expect_equal(out$dt_threads, 3L)
})

test_that("resolve_parallelism_settings: malformed env vars fall through", {
  out <- resolve_parallelism_settings(
    workers = NULL, dt_threads = NULL, ci_mode = FALSE,
    n_cores = 20L, env_workers = "not-a-number", env_dt_threads = ""
  )
  expect_equal(out$workers, 16L) # falls through to default
  expect_equal(out$dt_threads, 10L)
})

test_that("resolve_parallelism_settings: explicit args coerce and clamp >= 1", {
  out <- resolve_parallelism_settings(
    workers = 0, dt_threads = -3, ci_mode = FALSE,
    n_cores = 8L, env_workers = "", env_dt_threads = ""
  )
  expect_equal(out$workers, 1L)
  expect_equal(out$dt_threads, 1L)
})

test_that("setup_parallelism: returns settings invisibly with applied plan", {
  # Save and restore future::plan + DT threads to avoid bleeding into
  # other tests in the suite.
  prev_dt <- data.table::getDTthreads()
  on.exit(data.table::setDTthreads(prev_dt), add = TRUE)
  if (requireNamespace("future", quietly = TRUE)) {
    prev_plan <- future::plan()
    on.exit(future::plan(prev_plan), add = TRUE)
  }

  withr::with_envvar(
    new = c(
      TARGETS_CI_SMOKE = "true",
      IIE_PARALLEL_WORKERS = "",
      IIE_DT_THREADS = ""
    ),
    {
      result <- setup_parallelism()
    }
  )

  expect_type(result, "list")
  expect_equal(result$workers, 2L) # CI clamp
  expect_equal(result$dt_threads, 2L)
  expect_true(result$plan %in% c("multisession", "sequential"))
})
