context("http")

library(httr)

test_that("check that response is compressed", {
  r = trundler:::GET("https://api.trundler.dev/category")

  expect_equal(headers(r)$`content-encoding`, "gzip")
})
