#' Title
#'
#' @return
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

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()
}

#' Title
#'
#' @param retailer_id
#'
#' @return
#' @export
#'
#' @examples
retailer_products <- function(retailer_id) {
  url <- paste0(BASE_URL, "retailer/%d/products/") %>%
    sprintf(retailer_id)

  GET(url, UA, add_headers("X-Api-Key" = get_api_key())) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()
}
