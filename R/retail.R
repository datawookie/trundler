BASE_URL <- "http://3.91.58.113:8080/"

UA <- user_agent("Retail R Package")

#' @import magrittr
#' @import httr
#' @import jsonlite
#' @import tibble
cache <- new.env()

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
  get("api_key", envir = cache)
}
