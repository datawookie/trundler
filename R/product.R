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
  check_product_id(product_id)

  url <- paste0(base_url(), "product/%d") %>%
    sprintf(product_id)

  response <- GET(url)

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
    # Deal with duplicate barcodes.
    group_by_at(vars(-barcodes)) %>%
    summarise(barcodes = ifelse(sum(!is.na(barcodes)), list(barcodes), NA)) %>%
    ungroup()
}

#' Find products by name or brand
#'
#' @param product Filter by product name (treated as a regular expression).
#' @param brand Filter by product brand (treated as a regular expression).
#' @param regex Should filter be treated as a Regular Expression?
#' @param ignore_case	Should case be ignored?
#' @param barcode Filter by barcode.
#' @param head Return the data (\code{FALSE}) or the number of records (\code{TRUE})?
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Product details as a \code{data.frame} if \code{head} is \code{FALSE}, otherwise the number of products that would be returned.
#' @export
#'
#' @examples
#' \dontrun{
#' products(product = "coffee")
#' products(brand = "Illy")
#' products(product = "coffee", brand = "Illy")
#' products(product = "coffee", brand = "Illy", head = TRUE)
#' }
products <- function(product = NA, brand = NA, regex = TRUE, ignore_case = TRUE, barcode = NA, head = FALSE, ...) {
  url <- paste0(base_url(), "product")

  if (is.na(product) && is.na(brand) && is.na(barcode)) {
    warning("Without filter parameters this function will execute a large number of API calls and return a lot of data!", immediate. = TRUE)
  }

  if (!is.na(product)) {
    url <- param_set(url, key = "product", value = URLencode(product))
  }

  if (!is.na(brand)) {
    url <- param_set(url, key = "brand", value = URLencode(brand))
  }

  url <- param_set(url, key = "regex", value = param_boolean(regex))

  url <- param_set(url, key = "ignore_case", value = param_boolean(ignore_case))

  if (!is.na(barcode)) {
    url <- param_set(url, key = "barcode", value = URLencode(barcode))
  }

  products <- paginate(url, head, ...)

  if (!head) {
    if (nrow(products)) {
      products %>%
        rename(product_id = id) %>%
        select(product_id, retailer_id, product, brand, model, sku)
    } else {
      message("No products are currently available for this query")
      tibble(
        product_id = integer(),
        retailer_id = integer(),
        product = character(),
        brand = character(),
        model = character(),
        sku = character()
      )
    }
  } else {
    message(paste0(products, " products will be returned."))
    products
  }
}

#' Price history for a specific product
#'
#' @param product_id A product ID.
#' @param ... Arguments passed through to \code{paginate()}.
#' @param head Return the data (\code{FALSE}) or the number of records (\code{TRUE})?
#'
#' @return Price history as a \code{data.frame} if if \code{head} is \code{FALSE}, otherwise the number of price history entries that would be returned.
#' @export
#'
#' @examples
#' # Price history for a specific product.
#' \dontrun{
#' # Detailed price history for product with ID = 1.
#' product_prices(1)
#' # Number of entries in price history for product with ID = 1.
#' product_prices(1, head = TRUE)
#' }
product_prices <- function(product_id, head = FALSE, ...) {
  url <- paste0(base_url(), "product/%d/price") %>%
    sprintf(product_id)

  prices <- paginate(url, head)

  if (!head) {
    prices %>%
      mutate(price_effective = coalesce(price_promotion, price)
            ) %>%
      select(-available, available)
  } else {
    message(paste0(prices, " price history entries will be returned for this product query"))
    prices
  }
}
