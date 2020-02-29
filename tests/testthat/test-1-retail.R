context("retail")

test_that("API key", {
  expect_error(set_api_key(API_KEY), NA)
  expect_equal(get_api_key(), API_KEY)
})

test_that("URL", {
  expect_error(base_url(), NA)

  expect_error(set_server("8.8.8.8", 80), NA)
  expect_equal(base_url(), "http://8.8.8.8:80/")

  expect_error(set_base_url(base_url_original), NA)
  expect_equal(base_url(), base_url_original)
})
