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
    rename(product_id = id) %>%
    select(product_id, retailer_id, product_url = url, product, brand, model, sku, barcodes) %>%
    mutate(
      product_id = factor(product_id),
      retailer_id = factor(retailer_id)
    )
}

#' Find products by name or brand
#'
#' @param product Filter by product name (treated as a regular expression).
#' @param brand Filter by product brand (treated as a regular expression).
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Product details as a \code{data.frame}.
#' @export
#'
#' @examples
#' \dontrun{
#' products(product = "coffee")
#' products(brand = "Illy")
#' products(product = "coffee", brand = "Illy")
#' }
products <- function(product = NA, brand = NA, ...) {
  url <- paste0(base_url(), "product")

  if (!is.na(product)) {
    url <- param_set(url, key = "product", value = URLencode(product))
  }

  if (!is.na(brand)) {
    url <- param_set(url, key = "brand", value = URLencode(brand))
  }

  products <- paginate(url, ...)

  if (nrow(products)) {
    products %>%
      rename(product_id = id) %>%
      select(product_id, retailer_id, product, brand, model, sku)
  } else {
    message("No products are currently available for this query")
    tibble(
      product_id = factor(),
      retailer_id = factor(),
      product = character(),
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
