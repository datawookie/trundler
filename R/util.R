check_response_json <- function(response) {
  if (http_type(response) != "application/json") {
    stop("API did not return json.", call. = FALSE)
  }
}

check_response_error <- function(response) {
  if (http_error(response)) {
    stop(
      sprintf(
        "API request failed [%s].",
        status_code(response)
      ),
      call. = FALSE
    )
  }
}
