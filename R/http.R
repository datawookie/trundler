#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
GET <- function(url = NULL, config = list(), ...) {
  httr::GET(
    url,
    config,
    httr::user_agent("Retail R Package"),
    ...,
    handle = NULL
  )
}
