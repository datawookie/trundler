BASE_URL <- "http://3.91.58.113:8080/"

UA <- user_agent("Retail R Package")

#' @import magrittr
#' @import httr
#' @import jsonlite
#' @import tibble
cache <- new.env()

assign("base_url", BASE_URL, envir = cache)

#' Set IP and port for API server
#'
#' @param ip IP address
#' @param port Port
#'
#' @return
#' @export
#'
#' @examples
#' # Use local server
#' set_api_server("0.0.0.0", 8080)
set_api_server <- function(ip, port) {
  assign("base_url", sprintf("http://%s:%d/", ip, port), envir = cache)
}

base_url <- function() {
  get("base_url", envir = cache)
}

#' Set API key
#'
#' @param api_key API key.
#'
#' @export
#'
#' @examples
set_api_key <- function(api_key) {
  assign("api_key", api_key, envir = cache)
}

#' Retrieve API key
#'
#' @return API key.
#' @export
#'
#' @examples
get_api_key <- function() {
  api_key <- try(get("api_key", envir = cache), silent = TRUE)

  if (class(api_key) == "try-error" || api_key == "") {
    stop("Use set_api_key() to specify an API key.", call. = FALSE)
  } else {
    api_key
  }
}
