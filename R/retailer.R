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
    url <- paste0(base_url(), "retailer/%d") %>%
      sprintf(retailer_id)

    response <- GET(url, add_headers("X-Api-Key" = get_api_key()))
  }

  check_response_error(response)
  check_response_json(response)

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble() %>%
    rename(retailer_id = id)
}

#' Products for a specific retailer
#'
#' @param retailer_id A retailer ID.
#' @param name Filter by product name (treated as a regular expression).
#' @param brand Filter by product brand (treated as a regular expression).
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Details of all products for a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get products for a specific retailer.
#' \dontrun{
#' retailer_products(1)
#' retailer_products(9, name = "Nescafe")
#' }
retailer_products <- function(retailer_id, name = NA, brand = NA,...) {
  url <- paste0(base_url(), "retailer/%d/product") %>%
    sprintf(retailer_id)

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
    message("No products are currently available for this retailer.")
    tibble(
      product_id = integer(),
      name = character(),
      brand = character(),
      model = character(),
      sku = character()
    )
  }
}
