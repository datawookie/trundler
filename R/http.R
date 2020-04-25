#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5,...) {
  response <- httr::RETRY(
    "GET",
    url,
    config,
    httr::user_agent(glue("trundler [R] ({PKG_VERSION})")),
    ...,
    handle = NULL,
    times = retry,
    terminate_on = c(401, 404, 429)
  )

  # Check for "429 LIMIT EXCEEDED".
  #
  if (response$status_code == 429) {
    stop(content(response)$message, call. = FALSE)
  }

  response
}
