#' Interpolate prices for a specific product within a given date range.
#'
#' @param product_id A product ID.
#' @param date_min The minimum date for the interpolation range as a character string in the format "YYYY-mm-dd".  Defaults to the minimum date available for the specified product ID.
#' @param date_max The maximum date for the interpolation range as a character string in the format "YYYY-mm-dd".  Defaults to the maximum date available for the specified product ID.
#'
#' @return Interpolated prices for the specified (or default) date range as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Interpolate prices for a specific product within a given date range.
#' \dontrun{
#' price_complete(product_id = 1, date_min = "2020-01-01", date_max = "2020-12-31")
#' }
price_complete <- function(product_id, date_min = NULL, date_max = NULL) {
  if (!is.null(date_min)) {
    date_min <- try(as.Date(date_min, format="%Y-%m-%d"))
    if("try-error" %in% class(date_min) || is.na(date_min)) {
      stop("Argument date_min must be a character string with format YYYY-mm-dd.")
    }
  }

  if (!is.null(date_max)) {
    date_max <- try(as.Date(date_max, format="%Y-%m-%d"))
    if("try-error" %in% class(date_max) || is.na(date_max)) {
      stop("Argument date_max must be a character string with format YYYY-mm-dd.")
    }
  }

  df <- product_prices(product_id) %>%
    mutate(date = as.Date(time)) %>%
    # Consolidate prices where there are multiple prices per date (unusual, but it happens).
    group_by(date) %>%
    mutate(price = mean(price)) %>%
    slice(1) %>%
    ungroup()

  if (is.null(date_min)) {
    date_min <- min(df$date)
  }

  if (is.null(date_max)) {
    date_max <- max(df$date)
  }

  dates <- seq.Date(date_min, date_max, by = "day")

  # Only interpolate prices for the relevant time period
  df <- complete(df, date = dates, nesting(product_id)) %>%
    group_by(product_id) %>%
    mutate(price = approx(date, price, date, method = "constant", rule = 2)$y) %>%
    # Remove prices that weren't interpolated and that fall outside the relevant time period
    filter(date %in% dates)

  df <- df %>%
    mutate(is_interpolated = ifelse(is.na(time), TRUE, FALSE)) %>%
    select(product_id, date, price, is_interpolated)

  df
}
