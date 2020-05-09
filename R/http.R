#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5, ...) {
  api_key <- NULL
  try(api_key <- get_api_key(), silent = TRUE)
  #
  if (!is.null(api_key)) {
    headers = list("X-Api-Key" = api_key)
  } else {
    headers = list()
  }

  response <- httr::RETRY(
    "GET",
    url,
    config,
    httr::user_agent(glue("trundler [R] ({PKG_VERSION})")),
    ...,
    do.call(add_headers, headers),
    handle = NULL,
    times = retry,
    terminate_on = c(401, 404, 429)
  )

  # Check for "401 UNAUTHORISED".
  # Check for "429 LIMIT EXCEEDED".
  #
  if (response$status_code %in% c(401, 429)) {
    stop(content(response)$message, call. = FALSE)
  }

  response
}
