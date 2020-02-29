context("product")

test_that("product", {
  expect_error(product(1), NA)

  first_product <- product(1)

  expect_equal(names(first_product), c("id", "retailer_id", "url", "name", "brand", "sku", "barcodes"))
})

test_that("product prices", {
  expect_error(product_prices(1), NA)

  first_product_prices <- product_prices(1)

  expect_equal(names(first_product_prices), c("product_id", "time", "price", "price_promotion", "available"))
})
