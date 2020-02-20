context("retail")

test_that("register API key", {
  expect_error(set_api_key(API_KEY), NA)
})
