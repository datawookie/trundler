#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5,...) {
  httr::RETRY(
    "GET",
    url,
    config,
    httr::user_agent("Retail R Package"),
    ...,
    handle = NULL,
    times = retry,
    terminate_on = c(401, 404)
  )
}
