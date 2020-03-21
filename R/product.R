#' Details for a specific product
#'
#' @param product_id A product ID.
#'
#' @return Product details as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Detailts of a specific product.
#' \dontrun{
#' product(1)
#' }
product <- function(product_id) {
  url <- paste0(base_url(), "product/%d") %>%
    sprintf(product_id)

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  check_response_error(response)
  check_response_json(response)

  result <- response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON()

  if (is.null(result$brand)) result$brand = NA_character_
  if (is.null(result$model)) result$model = NA_character_
  if (is.null(result$sku)) result$sku = NA_character_
  if (!length(result$barcodes)) result$barcodes = NA_character_

  result %>%
    as_tibble() %>%
    rename(product_id = id)
}

#' Price history for a specific product
#'
#' @param product_id A product ID.
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Price history as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Price history for a specific product.
#' \dontrun{
#' product_prices(1)
#' }
product_prices <- function(product_id, ...) {
  paste0(base_url(), "product/%d/price") %>%
    sprintf(product_id) %>%
    paginate(...)
}
