context("stats")

test_that("stats daily (correct columns)", {
  skip_on_cran()

  stats_daily <- admin_stats_daily()

  expect_equal(names(stats_daily), c("date", "retailer_id", "count", "price_sum", "price_avg", "price_std", "price_min", "price_max"))
})
