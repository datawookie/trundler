context("retailer")

test_that("retailer list", {
  expect_error(retailer(), NA)

  retailer_list <- retailer()

  expect_equal(names(retailer_list), c("retailer_id", "retailer", "url", "currency"))
})

test_that("specific retailer", {
  expect_error(retailer(retailer_id), NA)

  first_retailer <- retailer(retailer_id)

  expect_equal(names(first_retailer), c("retailer_id", "retailer", "url", "currency"))
})

test_that("retailer products", {
  expect_error(retailer_products(retailer_id), NA)

  first_retailer_products <- retailer_products(retailer_id)

  expect_equal(names(first_retailer_products), c("product_id", "product", "brand", "model", "sku"))
})
