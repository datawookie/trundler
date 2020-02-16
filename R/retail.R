BASE_URL <- "http://3.91.58.113:8080/"

#' @import magrittr
#' @import httr
#' @import jsonlite
#' @import tibble
cache <- new.env()

#' Title
#'
#' @param api_key
#'
#' @return
#' @export
#'
#' @examples
set_api_key <- function(api_key) {
  assign("api_key", api_key, envir = cache)
}

#' Title
#'
#' @return
#' @export
#'
#' @examples
get_api_key <- function() {
  get("api_key", envir = cache)
}
