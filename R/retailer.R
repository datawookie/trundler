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

    response <- GET(url, UA)
  } else {
    url <- paste0(base_url(), "retailer/%d") %>%
      sprintf(retailer_id)

    response <- GET(url, UA, add_headers("X-Api-Key" = get_api_key()))
  }

  check_response_error(response)
  check_response_json(response)

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()
}

#' Products for a specific retailer
#'
#' @param retailer_id A retailer ID.
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Details of all products for a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get products for a specific retailer.
#' retailer_products(1)
retailer_products <- function(retailer_id, ...) {
  paste0(base_url(), "retailer/%d/product") %>%
    sprintf(retailer_id) %>%
    paginate(...)
}
