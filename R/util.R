#' Check that API response is JSON
#'
#' @param response
#'
#' @return
#'
#' @examples
check_response_json <- function(response) {
  if (http_type(response) != "application/json") {
    stop("API did not return json.", call. = FALSE)
  }
}

#' Check API response for errors
#'
#' @param response
#'
#' @return
#'
#' @examples
check_response_error <- function(response) {
  if (http_error(response)) {
    stop(
      sprintf(
        "API request failed [%s]: %s",
        status_code(response),
        # content(response)$message
      ),
      call. = FALSE
    )
  }
}
