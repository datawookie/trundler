# This script is for (internal) API testing only. Please don't run it!

library(trundler)
library(dplyr)
library(tictoc)
library(glue)

options(trundler.chatty = FALSE)

API_KEY <- Sys.getenv("TRUNDLER_KEY")
set_api_key(API_KEY)

RETAILER_ID = 74

items <- retailer_products(RETAILER_ID) %>% sample_n(1000)

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

options(mc.cores = 8)
#
message(glue("Number of cores: {availableCores()}."))

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
plan(strategy = multicore)
#
parallel_product_prices <- function(product_id) {
  set_api_key(API_KEY)
  product_prices(product_id)
}
#
tic()
items %>%
  pull(product_id) %>%
  future_map_dfr(parallel_product_prices)
toc()
