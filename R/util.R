#' Check that API response is JSON
#'
#' @param response A response object.
#'
#' @return NULL. Raises an error if the response is not JSON.
check_response_json <- function(response) {
  if (http_type(response) != "application/json") {
    stop("API did not return json.", call. = FALSE)
  }
}

#' Check API response for errors
#'
#' @param response A response object.
#'
#' @return NULL. Raises an error if response has an error code.
check_response_error <- function(response) {
  if (http_error(response)) {
    status <- status_code(response)
    error = glue("API request failed [{status}]")

    message <- content(response)$message
    if (!is.null(message)) {
      error = glue("{error}: {message}")
    }

    stop(error, call. = FALSE
    )
  }
}
