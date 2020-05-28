library(trundler)
library(dplyr)
library(microbenchmark)

API_KEY = Sys.getenv("TRUNDLER_KEY")
set_api_key(API_KEY)

# Some "quick" queries.
#
microbenchmark(
  retailer(),
  retailer(1),
  times = 100
)

# Test batch size.
#
microbenchmark(
  retailer_products(9, limit = 100),
  retailer_products(9, limit = 1000),
  retailer_products(9, limit = 10000),
  times = 10
)

microbenchmark(
  retailer_products(10, limit = 10000),
  times = 10
)
