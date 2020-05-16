#' Details of a retailer
#'
#' @param retailer_id A retailer ID.
#'
#' @return Details of either all retailers or a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get a table of all retailers.
#' retailer()
#'
#' # Get details of specific retailer.
#' retailer(1)
retailer <- function(retailer_id = NA) {
  if (is.na(retailer_id)) {
    url <- paste0(base_url(), "retailer")

    response <- GET(url)
  } else {
    check_retailer_id(retailer_id)

    url <- paste0(base_url(), "retailer/%d") %>%
      sprintf(retailer_id)

    response <- GET(url)
  }

  check_response_error(response)
  check_response_json(response)

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble() %>%
    rename(retailer_id = id, retailer_url = url)
}

#' Products for a specific retailer
#'
#' @param retailer_id A retailer ID.
#' @param product Filter by product name (treated as a regular expression).
#' @param brand Filter by product brand (treated as a regular expression).
#' @param regex Should filter be treated as a Regular Expression?
#' @param ignore_case	Should case be ignore?
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Details of all products for a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get products for a specific retailer.
#' \dontrun{
#' retailer_products(1)
#' retailer_products(9, product = "Nescafe")
#' }
retailer_products <- function(retailer_id, product = NA, brand = NA, regex = TRUE, ignore_case = TRUE, ...) {
  check_retailer_id(retailer_id)

  url <- paste0(base_url(), "retailer/%d/product") %>%
    sprintf(retailer_id)

  if (!is.na(product)) {
    url <- param_set(url, key = "product", value = URLencode(product))
  }

  if (!is.na(brand)) {
    url <- param_set(url, key = "brand", value = URLencode(brand))
  }

  url <- param_set(url, key = "regex", value = param_boolean(regex))

  url <- param_set(url, key = "ignore_case", value = param_boolean(ignore_case))

  products <- paginate(url, ...)

  if (nrow(products)) {
    products %>%
      rename(product_id = id) %>%
      select(product_id, product, brand, model, sku)
  } else {
    message("No products are currently available for this retailer.")
    tibble(
      product_id = integer(),
      product = character(),
      brand = character(),
      model = character(),
      sku = character()
    )
  }
}
