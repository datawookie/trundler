http_error_message <- function(status_code) {
  case_when(
    status_code == 401 ~ "Missing or invalid API key.",
    status_code == 404 ~ "Not found.",
    status_code == 429 ~ "Limit exceeded."
  )
}

#' Wrapper for httr::GET()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
GET <- function(url = NULL, config = list(), retry = 5, ...) {
  headers <- list()

  api_key <- NULL
  try(api_key <- get_api_key(), silent = TRUE)
  #
  if (!is.null(api_key)) {
    headers <- list("X-Api-Key" = api_key)
  }

  api_key <- NULL
  try(api_key <- get_rapidapi_key(), silent = TRUE)
  #
  if (!is.null(api_key)) {
    headers <- list("x-rapidapi-key" = api_key, "x-rapidapi-host" = "trundler.p.rapidapi.com")
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
    stop(http_error_message(response$status_code), call. = FALSE)
  }

  response
}

#' Wrapper for httr::HEAD()
#'
#' @param url URL to retrieve.
#' @param config Additional configuration settings.
#' @param ... Further named parameters.
#' @param retry Number of times to retry request on failure.
HEAD <- function(url = NULL, config = list(), retry = 5, ...) {
  headers <- list()

  api_key <- NULL
  try(api_key <- get_api_key(), silent = TRUE)
  #
  if (!is.null(api_key)) {
    headers <- list("X-Api-Key" = api_key)
  }

  api_key <- NULL
  try(api_key <- get_rapidapi_key(), silent = TRUE)
  #
  if (!is.null(api_key)) {
    headers <- list("x-rapidapi-key" = api_key, "x-rapidapi-host" = "trundler.p.rapidapi.com")
  }

  response <- httr::RETRY(
    "HEAD",
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
    stop(http_error_message(response$status_code), call. = FALSE)
  }

  response
}
