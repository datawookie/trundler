context("http")

library(httr)

test_that("check that response is compressed", {
  r = trundler:::GET("https://api.trundler.dev/category")

  expect_equal(headers(r)$`content-encoding`, "gzip")
})

test_that("http error message", {
  expect_equal(trundler:::http_error_message(401), "Missing or invalid API key.")
  expect_equal(trundler:::http_error_message(404), "Not found.")
  expect_equal(trundler:::http_error_message(429), "Limit exceeded.")
})

test_that("HEAD", {
  r = trundler:::HEAD(sprintf("https://api.trundler.dev/retailer/%d/product", retailer_product_count_id))

  product_count <- as.integer(r$headers$`x-total-count`)

  expect_equal(product_count, as.integer(retailer_product_count))
})


