test_that("write_with_contract writes parquet on contract pass", {
  tmp <- tempfile(fileext = ".parquet")
  on.exit(unlink(tmp), add = TRUE)

  df <- tibble::tibble(x = 1:5, y = letters[1:5])

  passing_contract <- function(d) {
    pointblank::create_agent(d) |>
      pointblank::col_exists(c("x", "y")) |>
      pointblank::col_vals_not_null("x")
  }

  expect_invisible(write_with_contract(df, passing_contract, tmp))
  expect_true(file.exists(tmp))

  read_back <- arrow::read_parquet(tmp)
  expect_equal(nrow(read_back), 5L)
  expect_named(read_back, c("x", "y"))
})

test_that("write_with_contract halts and does not write on contract fail", {
  tmp <- tempfile(fileext = ".parquet")
  on.exit(unlink(tmp), add = TRUE)

  df <- tibble::tibble(x = c(1L, NA_integer_, 3L))

  failing_contract <- function(d) {
    pointblank::create_agent(d) |>
      pointblank::col_vals_not_null("x")
  }

  expect_error(
    write_with_contract(df, failing_contract, tmp),
    regexp = "Contract failed"
  )
  expect_false(file.exists(tmp))
})

test_that("write_with_contract rejects non-agent contract return", {
  tmp <- tempfile(fileext = ".parquet")
  on.exit(unlink(tmp), add = TRUE)

  df <- tibble::tibble(x = 1:3)
  bad_contract <- function(d) "not an agent"

  expect_error(
    write_with_contract(df, bad_contract, tmp),
    regexp = "pointblank.*agent"
  )
  expect_false(file.exists(tmp))
})
