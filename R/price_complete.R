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
#' Interpolate prices for a specific product within a given date range.
#' \dontrun{
#' price_complete(product_id = 1, date_min = "2020-01-01", date_max = "2020-12-31")
#' }
price_complete <- function(product_id, date_min = NULL, date_max = NULL) {

  if (!is.null(date_min)) {
    date_min_check <- try(as.Date(date_min, format="%Y-%m-%d"))
    if("try-error" %in% class(date_min_check) || is.na(date_min_check)) {
      stop("Argument date_min must have format %Y-%m-%d")
    }
    date_min <- as.Date(date_min)
  }

  if (!is.null(date_max)) {
    date_max_check <- try(as.Date(date_max, format="%Y-%m-%d"))
    if("try-error" %in% class(date_max_check) || is.na(date_max_check)) {
      stop("Argument date_max must have format %Y-%m-%d")
    }
    date_max <- as.Date(date_max)
  }

  df <- product_prices(product_id) %>%
    mutate(date = as.Date(time))

  date_start <- if_else(is.null(date_min), min(df$date), date_min)
  date_end <- if_else(is.null(date_max), max(df$date), date_max)

  dates <- seq.Date(date_start, date_end, by = "day")

  complete(df, date = dates, nesting(product_id)) %>%
    group_by(product_id) %>%
    mutate(price = approx(date, price, date, method = "constant", rule = 2)$y,
           is_interpolated = ifelse(!is.na(time), TRUE, FALSE)) %>%
    select(date, price, is_interpolated)
}
