BASE_URL <- "https://api.trundler.dev/"
RAPIDAPI_URL <- "https://trundler.p.rapidapi.com/"

PKG_VERSION <- utils::packageDescription('trundler')$Version

cache <- new.env()

# Avoid some "no visible binding" notes with devtools::check().
#
globalVariables(
  c(
    "annotation_custom",
    "auth_id",
    "available",
    "barcodes",
    "brand",
    "category_id",
    "category_label",
    "category_parent_id",
    "element_text",
    "finish_time",
    "from",
    "is_interpolated",
    "label",
    "margin",
    "model",
    "parent_id",
    "path",
    "price",
    "price_promotion",
    "price_total",
    "product_id",
    "retailer_id",
    "sku",
    "start_time",
    "time",
    "theme",
    "theme_classic",
    "to"
  )
)

#' @import jsonlite
#' @import tibble
#' @import dplyr
#' @import tidyselect
#' @import tidygraph
#' @import tidyr
#' @import progressr
#' @import ggplot2
#' @import ggtext
#' @importFrom magrittr %>%
#' @importFrom utils URLencode
#' @importFrom glue glue
#' @importFrom httr add_headers
#' @importFrom httr http_error
#' @importFrom httr http_type
#' @importFrom httr content
#' @importFrom httr status_code
#' @importFrom stats approx
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
#' Specify the key for accessing the Trundler API. You can either get an internal
#' key directly from us or a RapidAPI key from the \href{https://rapidapi.com/datawookie/api/trundler}{Trundler page on RapidAPI}.
#'
#' Automatically determines which type of key is being used and authenticates appropriately.
#'
#' @param api_key API key.
#'
#' @export
#'
#' @examples
#' # Authenticate using an internal API key.
#' set_api_key("8f9f3c4e-5dd6-4bff-3a2c-592b45cf2437")
#'
#' # Authenticate using a RapidAPI key.
#' set_api_key("5a1ae0ce24mshd483dae6ab7308dp129ef6jsn1f473053d6b0")
set_api_key <- function(api_key) {
  if (grepl("^[[:lower:][:digit:]]{50}$", api_key)) {
    message("Using a RapidAPI key.")
    assign("rapidapi_key", api_key, envir = cache)
    set_base_url(RAPIDAPI_URL)
  }
  else if (grepl("^[[:lower:][:digit:]-]{36}$", api_key)) {
    assign("api_key", api_key, envir = cache)
  }
  else {
    if (api_key == "" || is.na(api_key) || is.null(api_key)) {
      stop("API key is missing.", call. = FALSE)
    } else {
      stop(glue("Unknown API key type: '{api_key}'."), call. = FALSE)
    }
  }
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
