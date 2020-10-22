context("price_complete")

test_that("price_complete", {
  skip_on_cran()
  first_product <- price_complete(product_id, "2020-01-01", "2020-12-31")
  expect_equal(names(first_product), c("product_id", "date", "price", "is_interpolated"))
})

test_that("default min date is correct", {
  skip_on_cran()
  first_date_no_interpolation <- tail(as.Date(product_prices(product_id)$time), n = 1)
  first_date_with_interpolation <- price_complete(product_id,
                                                     date_min = NULL,
                                                     date_max = "2020-12-31")$date[1]
  expect_equal(first_date_no_interpolation, first_date_with_interpolation)
})

test_that("default max date is correct", {
  skip_on_cran()
  last_date_no_interpolation <- as.Date(product_prices(product_id)$time)[1]
  last_date_with_interpolation <- tail(price_complete(product_id,
                                                  date_min = "2020-01-01",
                                                  date_max = NULL)$date, n = 1)
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

test_that("correct minimum date", {
  skip_on_cran()
  date_min <- price_complete(product_id,
                             date_min = "2020-01-01",
                             date_max = "2020-12-31")$date[1]
  expect_equal(date_min, as.Date("2020-01-01"))
})

test_that("correct maximum date", {
  skip_on_cran()
  date_max <- tail(price_complete(product_id,
                             date_min = "2020-01-01",
                             date_max = "2020-12-31")$date, n = 1)
  expect_equal(date_max, as.Date("2020-12-31"))
})

test_that("is_interpolated", {
  skip_on_cran()
  is_interpolated <- price_complete(product_id, date_min = "2019-01-01")$is_interpolated[1]
  expect_equal(is_interpolated, TRUE)
})
