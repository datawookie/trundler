context("price_complete")

MAX_DATE = as.Date(max(product_prices(product_id)$time)) + 10

test_that("price_complete", {
  skip_on_cran()
  first_product <- price_complete(product_id, "2020-01-01", MAX_DATE)
  expect_equal(names(first_product), c("product_id", "date", "price", "is_interpolated"))
})

test_that("default min date is correct", {
  skip_on_cran()
  first_date_no_interpolation <- as.Date(product_prices(product_id)$time) %>%
    sort(decreasing = FALSE) %>%
    first()

  first_date_with_interpolation <- price_complete(
    product_id,
    date_min = NULL,
    date_max = MAX_DATE
  ) %>%
    pull(date) %>%
    sort(decreasing = FALSE) %>%
    first()

  expect_equal(first_date_no_interpolation, first_date_with_interpolation)
})

test_that("default max date is correct", {
  skip_on_cran()
  last_date_no_interpolation <- as.Date(product_prices(product_id)$time) %>%
    sort() %>%
    last()

  last_date_with_interpolation <- price_complete(
    product_id,
    date_min = "2020-01-01",
    date_max = NULL
  ) %>%
    pull(date) %>%
    sort() %>%
    last()

  expect_equal(last_date_no_interpolation, last_date_with_interpolation)
})

test_that("valid min date format", {
  skip_on_cran()
  expect_error(price_complete(product_id, date_min = "01-01", date_max = NULL))
})

test_that("valid max date format", {
  skip_on_cran()
  expect_error(price_complete(product_id, date_min = NULL, date_max = "20201231"))
})

test_that("correct minimum date when date range extended", {
  skip_on_cran()
  date_min <- price_complete(
    product_id,
    date_min = "2019-01-01",
    date_max = MAX_DATE
  ) %>%
    pull(date) %>%
    first()
  expect_equal(date_min, as.Date("2019-01-01"))
})

test_that("correct minimum date when date range abbreviated", {
  skip_on_cran()
  date_min <- price_complete(
    product_id,
    date_min = "2020-10-01",
    date_max = "2020-10-10"
  ) %>%
    pull(date) %>%
    first()
  expect_equal(date_min, as.Date("2020-10-01"))
})

test_that("correct maximum date when date range extended", {
  skip_on_cran()
  date_max <- price_complete(
    product_id,
    date_min = "2020-01-01",
    date_max = MAX_DATE
  ) %>%
    pull(date) %>%
    last()
  expect_equal(date_max, as.Date(MAX_DATE))
})

test_that("correct maximum date when date range abbreviated", {
  skip_on_cran()
  date_max <- price_complete(
    product_id,
    date_min = "2020-10-01",
    date_max = "2020-10-10"
  ) %>%
    pull(date) %>%
    last()
  expect_equal(date_max, as.Date("2020-10-10"))
})

test_that("is_interpolated", {
  skip_on_cran()
  is_interpolated <- price_complete(
    product_id,
    date_min = "2019-01-01"
  ) %>%
    pull(is_interpolated) %>%
    first()
  expect_equal(is_interpolated, TRUE)
})
