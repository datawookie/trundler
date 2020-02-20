#' Details of a retailer
#'
#' @param retailer_id A retailer ID.
#'
#' @return Details of either all retailers or a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
retailer <- function(retailer_id = NA) {
  if (is.na(retailer_id)) {
    url <- paste0(BASE_URL, "retailer/")

    response <- GET(url, UA)
  } else {
    url <- paste0(BASE_URL, "retailer/%d/") %>%
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
#'
#' @return Details of all products for a specific retailer as a \code{data.frame}.
#' @export
#'
#' @examples
retailer_products <- function(retailer_id) {
  url <- paste0(BASE_URL, "retailer/%d/products/") %>%
    sprintf(retailer_id)

  response <- GET(url, UA, add_headers("X-Api-Key" = get_api_key()))

  check_response_error(response)
  check_response_json(response)

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()
}
