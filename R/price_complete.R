#' Interpolate prices within a given date range
#'
#' @param price_data A \code{data.frame} containing the following columns: date, price, SKU.
#' @param date_min The minimum date for the interpolation range.  Defaults to the minimum date in the data argument.
#' @param date_max The maximum date for the interpolation range.  Defaults to the maximum date in the data argument.
#'
#' @return Interpolated prices as a \code{data.frame}.
#' @export
price_complete <- function(price_data, date_min = NULL, date_max = NULL) {

  # Consolidate products (multiple product_ids map to a single SKU)
  price_data <- price_data %>%
    group_by(date, sku) %>%
    summarise(price = mean(price), .groups = "drop")

  # If no date is specified, then use the minimum and maximum dates as the date range
  if (is.null(date_min) && is.null(date_max)) {
  date_min <- min(price_data$date)
  date_max <- max(price_data$date)
  }

  # Create a range of dates
  dates <- seq.Date(as.Date(date_min), as.Date(date_max), by = "day")

  # Expand to cover full date range, interpolate prices for missing dates, and get the average price for each day
  complete(price_data, date = dates, nesting(sku)) %>%
    group_by(sku) %>%
    mutate(price = approx(date, price, date, method = "constant", rule = 2)$y)
}

products <- map_dfr(c(1:3, 10000, 50000), product) %>%
  inner_join(retailer(), by = 'retailer_id')

prices <- map_dfr(c(1:3, 10000, 50000), product_prices) %>%
  inner_join(products, by = 'product_id')
