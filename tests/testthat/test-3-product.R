context("product")

test_that("product", {
  expect_error(product(product_id), NA)

  first_product <- product(product_id)

  expect_equal(names(first_product), c("id", "retailer_id", "url", "name", "brand", "sku", "barcodes"))
})

test_that("product prices (call succeeds)", {
  expect_error(product_prices(product_id), NA)
  expect_error(product_prices(product_id, verbose = TRUE), NA)
})

test_that("product prices (correct columns)", {
  first_product_prices <- product_prices(product_id)

  expect_equal(names(first_product_prices), c("product_id", "time", "price", "price_promotion", "available"))
})
