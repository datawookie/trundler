context("price")

test_that("product prices (call succeeds)", {
  expect_error(product_prices(product_id), NA)
  expect_error(product_prices(product_id, verbose = TRUE), NA)
})

test_that("product prices (correct columns)", {
  first_product_prices <- product_prices(product_id)

  expect_equal(names(first_product_prices), c("product_id", "time", "price", "price_promotion", "price_effective", "available"))
})

test_that("product prices count", {
  product_prices_count <- product_prices(product_id, head = TRUE)

  expect_type(product_prices_count, "integer")
  expect_length(product_prices_count, 1)
})
