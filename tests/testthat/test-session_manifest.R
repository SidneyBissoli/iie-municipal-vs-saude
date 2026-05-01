test_that("build_session_manifest writes a valid JSON with hashes", {
  tmp_dir <- tempfile()
  dir.create(tmp_dir)
  on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

  art1 <- file.path(tmp_dir, "alpha.R")
  art2 <- file.path(tmp_dir, "beta.md")
  writeLines("x <- 1", art1)
  writeLines("# beta", art2)

  manifest_dir <- file.path(tmp_dir, ".claude")
  m <- build_session_manifest(
    session_id   = "TEST",
    artifacts    = c(art1, art2),
    contracts    = NULL,
    manifest_dir = manifest_dir
  )

  out <- file.path(manifest_dir, "sessao-TEST-manifest.json")
  expect_true(file.exists(out))

  parsed <- jsonlite::read_json(out, simplifyVector = FALSE)
  expect_equal(parsed$session_id, "TEST")
  expect_length(parsed$artifacts, 2L)
  expect_equal(
    parsed$artifacts[[1]]$sha256,
    digest::digest(file = art1, algo = "sha256")
  )
  expect_equal(parsed$artifacts[[1]]$pointblank_status, "n/a")
})

test_that("verify_last_session_manifest passes on unchanged artefacts", {
  tmp_dir <- tempfile()
  dir.create(tmp_dir)
  on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

  art <- file.path(tmp_dir, "fixed.R")
  writeLines("x <- 1", art)

  manifest_dir <- file.path(tmp_dir, ".claude")
  build_session_manifest(
    session_id   = "001",
    artifacts    = art,
    manifest_dir = manifest_dir
  )

  # `strict = FALSE` so the report is returned even when commit SHAs differ
  # (the test runs in any working dir; commit may or may not match).
  rep <- verify_last_session_manifest(
    manifest_dir = manifest_dir,
    contracts    = NULL,
    strict       = FALSE
  )

  expect_true(rep$details[[1]]$status %in% c("pass", "warn"))
  expect_equal(rep$details[[1]]$expected, rep$details[[1]]$actual)
})

test_that("verify_last_session_manifest detects tampered files", {
  tmp_dir <- tempfile()
  dir.create(tmp_dir)
  on.exit(unlink(tmp_dir, recursive = TRUE), add = TRUE)

  art <- file.path(tmp_dir, "to-be-tampered.R")
  writeLines("x <- 1", art)

  manifest_dir <- file.path(tmp_dir, ".claude")
  build_session_manifest(
    session_id   = "002",
    artifacts    = art,
    manifest_dir = manifest_dir
  )

  # Tamper.
  writeLines("x <- 99", art)

  rep <- verify_last_session_manifest(
    manifest_dir = manifest_dir,
    contracts    = NULL,
    strict       = FALSE
  )

  expect_equal(rep$details[[1]]$status, "fail")
  expect_false(rep$status == "pass")
})

test_that("verify_last_session_manifest reports empty when no manifest exists", {
  empty_dir <- tempfile()
  dir.create(empty_dir)
  on.exit(unlink(empty_dir, recursive = TRUE), add = TRUE)

  rep <- verify_last_session_manifest(
    manifest_dir = empty_dir,
    strict       = FALSE
  )
  expect_equal(rep$status, "empty")
})
