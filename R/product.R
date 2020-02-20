#' Title
#'
#' @return
#' @export
#'
#' @examples
product <- function(product_id) {
  url <- paste0(BASE_URL, "product/%d/") %>%
    sprintf(product_id)

  result <- GET(url, UA, add_headers("X-Api-Key" = get_api_key())) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON()

  if (is.null(result$sku)) result$sku = NA
  if (!length(result$barcodes)) result$barcodes = NA

  result %>%
    as_tibble()
}

#' Title
#'
#' @param product_id
#'
#' @return
#' @export
#'
#' @examples
product_prices <- function(product_id) {
  url <- paste0(BASE_URL, "product/%d/prices/") %>%
    sprintf(product_id)

  result <- GET(url, UA, add_headers("X-Api-Key" = get_api_key())) %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON()

  result %>%
    as_tibble()
}
