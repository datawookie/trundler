# This script is for (internal) API testing only. Please don't run it!

library(retail)
library(dplyr)

API_KEY <- Sys.getenv("TRUNDLER_KEY")

set_api_key(API_KEY)

products <- retailer_products(5)

# Hit API moderately hard.
#
library(purrr)
#
products %>%
  pull(product_id) %>%
  map(product_prices)

# Hit API pretty hard (parallel calls).
#
library(furrr)
#
options(future.supportsMulticore.unstable = "quiet")
plan(multisession)
#
products %>%
  pull(product_id) %>%
  future_map(product_prices)
