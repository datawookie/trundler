context("retailer")

test_that("retailer list", {
  expect_error(retailer(), NA)

  retailer_list <- retailer()

  expect_equal(names(retailer_list), c("id", "name", "url", "currency"))
})
