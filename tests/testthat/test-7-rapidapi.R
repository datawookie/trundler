context("rapidapi")

test_that("API key", {
  skip_on_cran()

  expect_error(set_rapidapi_key(RAPIDAPI_KEY), NA)
  expect_equal(get_rapidapi_key(), RAPIDAPI_KEY)
})

test_that("URL", {
  skip_on_cran()

  expect_equal(base_url(), RAPIDAPI_URL)
})

test_that("endpoints", {
  skip_on_cran()

  expect_error(retailer(), NA)
  expect_error(retailer(retailer_id), NA)
  expect_error(retailer_products(retailer_id), NA)
  expect_error(product(product_id), NA)
  expect_error(product_prices(product_id), NA)
})
