context("product")

test_that("product", {
  skip_on_cran()

  expect_error(product(product_id), NA)

  first_product <- product(product_id)

  expect_equal(names(first_product), c("product_id", "retailer_id", "product_url", "product", "brand", "model", "sku", "barcodes"))
})

test_that("product prices (call succeeds)", {
  skip_on_cran()

  expect_error(product_prices(product_id), NA)
  expect_error(product_prices(product_id, verbose = TRUE), NA)
})

test_that("product prices (correct columns)", {
  skip_on_cran()

  first_product_prices <- product_prices(product_id)

  expect_equal(names(first_product_prices), c("product_id", "time", "price", "price_promotion", "price_effective", "available"))
})

test_that("brand is NULL", {
  skip_on_cran()

  product_null_brand <- product(product_id_null_brand)

  expect_equal(product_null_brand$brand, NA_character_)
})

test_that("sku is NULL", {
  skip_on_cran()

  product_null_sku <- product(product_id_null_sku)

  expect_equal(product_null_sku$sku, NA_character_)
})

test_that("product name has apostrophe", {
  skip_on_cran()

  expect_error(products(product = "Jerry's"), NA)
})

test_that("brand name has apostrophe", {
  skip_on_cran()

  expect_error(products(brand = "Jerry's"), NA)
})
