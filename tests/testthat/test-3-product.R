context("product")

test_that("product", {
  skip_on_cran()

  expect_error(product(product_id), NA)

  first_product <- product(product_id)

  expect_equal(names(first_product), c("product_id", "retailer_id", "product_url", "product", "brand", "model", "sku", "barcodes"))
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

test_that("product count", {
  skip_on_cran()

  product_count <- products(head = TRUE)

  expect_type(product_count, "integer")
  expect_length(product_count, 1)
})
