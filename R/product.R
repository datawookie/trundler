#' Details for a specific product
#'
#' @param product_id A product ID.
#'
#' @return Product details as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Details of a specific product.
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

#' Find products by name or brand
#'
#' @param name Filter by product name (treated as a regular expression).
#' @param brand Filter by product brand (treated as a regular expression).
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Product details as a \code{data.frame}.
#' @export
#'
#' @examples
#' \dontrun{
#' product_filter(name = "coffee")
#' product_filter(brand = "Illy")
#' product_filter(name = "coffee", brand = "Illy")
#' }
product_filter <- function(name = NA, brand = NA, ...) {
  url <- paste0(base_url(), "product")

  if (!is.na(name)) {
    url <- param_set(url, key = "name", value = name)
  }

  if (!is.na(brand)) {
    url <- param_set(url, key = "brand", value = brand)
  }

  products <- paginate(url, ...)

  if (nrow(products)) {
    products %>% rename(product_id = id)
  } else {
    message("No products are currently available for this query")
    tibble(
      product_id = integer(),
      retailer_id = integer(),
      name = character(),
      brand = character(),
      model = character(),
      sku = character()
    )
  }
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
