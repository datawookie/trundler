library(retail)
library(dplyr)
library(microbenchmark)

API_KEY = Sys.getenv("RETAIL_KEY")

set_api_key(API_KEY)

microbenchmark(
  retailer_products(9, limit = 100),
  retailer_products(9, limit = 1000),
  retailer_products(9, limit = 10000),
  times = 10
  )
