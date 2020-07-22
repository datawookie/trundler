# This script is for (internal) API testing only. Please don't run it!

library(trundler)
library(dplyr)
library(tictoc)

API_KEY <- Sys.getenv("TRUNDLER_KEY")
set_api_key(API_KEY)

items <- retailer_products(102) %>% top_n(100)

# ---------------------------------------------------------------------------------------------------------------------

# Hit API moderately hard.
#
library(purrr)
#
tic()
items %>%
  pull(product_id) %>%
  map_dfr(product_prices)
toc()

# ---------------------------------------------------------------------------------------------------------------------

# Hit API pretty hard (parallel calls).
#
library(furrr)
#
options(future.supportsMulticore.unstable = "quiet")

# With sequential plan the timing should be about the same as just using purrr.
#
plan(strategy = sequential)
#
tic()
items %>%
  pull(product_id) %>%
  future_map_dfr(product_prices)
toc()

# TODO:
#
# - Improve handling of API key. See https://rdrr.io/cran/furrr/man/future_options.html.
# - Maybe using multicore for the strategy will do the trick?
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
