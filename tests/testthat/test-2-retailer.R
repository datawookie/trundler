context("retailer")

test_that("retailer list", {
  expect_error(retailer(), NA)

  retailer_list <- retailer()

  expect_equal(names(retailer_list), c("id", "name", "url", "currency"))
})

test_that("specific retailer", {
  expect_error(retailer(1), NA)

  first_retailer <- retailer(1)

  expect_equal(names(first_retailer), c("id", "name", "url", "currency"))
})
