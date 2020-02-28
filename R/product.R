#' Details for a specific product
#'
#' @param product_id A product ID.
#'
#' @return Product details as a \code{data.frame}.
#' @export
#'
#' @examples
product <- function(product_id) {
  url <- paste0(base_url(), "product/%d") %>%
    sprintf(product_id)

  response <- GET(url, UA, add_headers("X-Api-Key" = get_api_key()))

  check_response_error(response)
  check_response_json(response)

  result <- response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON()

  print(result)

  if (is.null(result$brand)) result$brand = NA
  if (is.null(result$sku)) result$sku = NA
  if (!length(result$barcodes)) result$barcodes = NA

  result %>%
    as_tibble()
}

#' Price history for a specific product
#'
#' @param product_id A product ID.
#'
#' @return Price history as a \code{data.frame}.
#' @export
#'
#' @examples
product_prices <- function(product_id) {
  paste0(base_url(), "product/%d/price") %>%
    sprintf(product_id) %>%
    paginate()
}
