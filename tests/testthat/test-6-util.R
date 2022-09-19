context("util")

test_that("check that response is JSON", {
  response_json <- GET("https://httpbin.org/response-headers")
  expect_error(check_response_json(response_json), NA)
})

test_that("check for response with errors (with and without message)", {
  response_error_404 <- GET("https://httpbin.org/status/404")

  expect_error(check_response_error(response_error_404))

  response_error_404$headers["content-type"] <- "application/json"
  response_error_404$content <- writeBin('{"message": "Something is rotten in the state of Denmark."}', raw())

  expect_error(check_response_error(response_error_404))
})
