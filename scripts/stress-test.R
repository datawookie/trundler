# This script is for (internal) API testing only. Please don't run it!

library(trundler)
library(dplyr)
library(tictoc)

API_KEY <- Sys.getenv("TRUNDLER_KEY")
set_api_key(API_KEY)

products <- retailer_products(5)

products <- products %>% top_n(100)

# ---------------------------------------------------------------------------------------------------------------------

# Hit API moderately hard.
#
library(purrr)
#
tic()
products %>%
  pull(product_id) %>%
  map(product_prices)
toc()

# ---------------------------------------------------------------------------------------------------------------------

# Hit API pretty hard (parallel calls).
#
library(furrr)
#
options(future.supportsMulticore.unstable = "quiet")

plan(strategy = sequential)
#
tic()
products %>%
  pull(product_id) %>%
  future_map(product_prices)
toc()

# TODO: Improve handling of API key. See https://rdrr.io/cran/furrr/man/future_options.html.
#
plan(strategy = multisession)
#
parallel_product_prices <- function(product_id) {
  set_api_key(API_KEY)
  product_prices(product_id)
}
#
tic()
products %>%
  pull(product_id) %>%
  future_map(parallel_product_prices)
toc()
