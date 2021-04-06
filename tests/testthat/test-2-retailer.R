context("retailer")

test_that("retailer list", {
  skip_on_cran()

  expect_error(retailer(), NA)

  retailer_list <- retailer()

  expect_equal(names(retailer_list), c("retailer_id", "retailer", "retailer_url", "currency", "visible", "priority"))
})

test_that("specific retailer", {
  skip_on_cran()

  expect_error(retailer(retailer_id), NA)

  first_retailer <- retailer(retailer_id)

  expect_equal(names(first_retailer), c("retailer_id", "retailer", "retailer_url", "currency", "visible", "priority"))
})

test_that("retailer products", {
  skip_on_cran()

  expect_error(retailer_products(retailer_id), NA)

  first_retailer_products <- retailer_products(retailer_id)

  expect_equal(names(first_retailer_products), c("product_id", "product", "brand", "model", "sku"))
})

test_that("retailer product count", {
  skip_on_cran()

  product_count <- retailer_products(retailer_id, head = TRUE)

  expect_type(product_count, "integer")
  expect_length(product_count, 1)
})

test_that("specific brand", {
  skip_on_cran()

  retailer_products_with_brand <- retailer_products(retailer_id, brand = retailer_brand)

  expect_equal(names(retailer_products_with_brand), c("product_id", "product", "brand", "model", "sku"))
})

test_that("specific product", {
  skip_on_cran()

  retailer_products_with_product <- retailer_products(retailer_id, product = retailer_product)

  expect_equal(names(retailer_products_with_product), c("product_id", "product", "brand", "model", "sku"))
})

test_that("retailer with no products", {
  skip_on_cran()

  expect_message(retailer_products(retailer_no_products), "No products are currently available for this retailer.")
})
