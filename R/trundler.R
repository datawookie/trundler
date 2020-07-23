BASE_URL <- "https://api.trundler.dev/"
RAPIDAPI_URL <- "https://trundler.p.rapidapi.com/"

PKG_VERSION <- utils::packageDescription('trundler')$Version

cache <- new.env()

# Avoid some "no visible binding" notes with devtools::check().
#
globalVariables(
  c(
    "auth_id",
    "retailer_id",
    "product_id",
    "parent_id",
    "category_id",
    "category_parent_id",
    "path",
    "from",
    "to",
    "start_time",
    "finish_time",
    "price_total",
    "brand",
    "model",
    "sku",
    "label",
    "category_label",
    "barcodes",
    "price",
    "price_promotion",
    "available"
  )
)

#' @import magrittr
#' @import jsonlite
#' @import tibble
#' @import dplyr
#' @import tidyselect
#' @import tidygraph
#' @import progressr
#' @importFrom utils URLencode
#' @importFrom glue glue
#' @importFrom httr add_headers
#' @importFrom httr http_error
#' @importFrom httr http_type
#' @importFrom httr content
#' @importFrom httr status_code
#' @importFrom urltools param_set

assign("base_url", BASE_URL, envir = cache)

#' Set IP and port for API server
#'
#' @param ip IP address for API server.
#' @param port Port on which API is running.
#'
#' @export
#'
#' @examples
#' # Use local server
#' set_server("0.0.0.0", 8080)
set_server <- function(ip, port) {
  assign("base_url", sprintf("http://%s:%d/", ip, port), envir = cache)
}

#' Set base URL for API
#'
#' @param url URL to access API.
#'
#' @export
#'
#' @examples
#' # Use local server
#' set_base_url("http://0.0.0.0:8080/")
set_base_url <- function(url) {
  assign("base_url", url, envir = cache)
}

#' Get base URL for API
#'
#' @return API base URL.
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
#' set_api_key("8f9f3c4e-5dd6-4bff-3a2c-592b45cf2437")
set_api_key <- function(api_key) {
  assign("api_key", api_key, envir = cache)
}

#' Retrieve API key
#'
#' @return API key.
#' @export
#'
#' @examples
#' \dontrun{
#' set_api_key("8f9f3c4e-5dd6-4bff-3a2c-592b45cf2437")
#' get_api_key()
#' }
get_api_key <- function() {
  api_key <- try(get("api_key", envir = cache), silent = TRUE)

  if (class(api_key) == "try-error" || api_key == "") {
    stop("Use set_api_key() to specify an API key.", call. = FALSE)
  } else {
    api_key
  }
}

#' Set RapidAPI key
#'
#' @param api_key API key for RapidAPI.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' set_rapidapi_key("5a1ae0ce24mshd483dae6ab7308dp129ef6jsn1f473053d6b0")
#' }
set_rapidapi_key <- function(api_key) {
  assign("rapidapi_key", api_key, envir = cache)
  set_base_url(RAPIDAPI_URL)
}

#' Retrieve RapidAPI key
#'
#' @return API key for RapidAPI.
#' @export
get_rapidapi_key <- function() {
  api_key <- try(get("rapidapi_key", envir = cache), silent = TRUE)

  if (class(api_key) == "try-error" || api_key == "") {
    stop("Use set_rapidapi_key() to specify a RapidAPI key.", call. = FALSE)
  } else {
    api_key
  }
}
