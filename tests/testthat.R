# Test runner for the project's `R/` utilities.
# Source the functions under test directly (this is not a package); each
# `test-*.R` file may also `source()` what it needs explicitly.

library(testthat)

invisible(lapply(
  list.files("R", pattern = "\\.R$", full.names = TRUE),
  source
))

test_dir("tests/testthat", reporter = "summary", stop_on_failure = TRUE)
