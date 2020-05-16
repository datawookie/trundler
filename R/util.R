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

#' Convert URL parameter into Boolean.
#'
#' @param bool A Boolean string (either "true" or "false").
#'
#' @return A Boolean value (either TRUE or FALSE).
param_boolean <- function(bool) {
  ifelse(bool, "true", "false")
}

check_retailer_id <- function(retailer_id) {
  if (!is.integer(retailer_id) && !is.numeric(retailer_id)) {
    stop("Retailer ID must be a number.", call. = FALSE)
  }
}

check_product_id <- function(product_id) {
  if (!is.integer(product_id) && !is.numeric(product_id)) {
    stop("Product ID must be a number.", call. = FALSE)
  }
}
