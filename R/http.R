#' @importFrom httr add_headers
#' @importFrom httr http_error
#' @importFrom httr http_type
#' @importFrom httr content
#' @importFrom httr status_code

UA <- httr::user_agent("Retail R Package")

#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
GET <- function(url = NULL, config = list(), ...) {
  httr::GET(
    url,
    config,
    ...,
    handle = NULL
  )
}
