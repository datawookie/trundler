#' Information on all API keys
#'
#' @return
#' @export
admin_auth <- function() {
  url <- paste0(base_url(), "admin/auth")

  # response <- GET(url)
  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    rename(auth_id = id) %>%
    arrange(auth_id)
}

#' Usage statistics on all API keys
#'
#' @return
#' @export
admin_auth_count <- function() {
  url <- paste0(base_url(), "admin/auth/count")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    select(-id) %>%
    arrange(auth_id, date)
}

#' Get statistics per crawl
#'
#' @return
#' @export
admin_stats <- function() {
  url <- paste0(base_url(), "admin/stats")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    rename(stats_id = id)
}

#' Get status statistics per crawl
#'
#' @return
#' @export
admin_stats_status <- function() {
  url <- paste0(base_url(), "admin/stats/status")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    select(-id)
}

#' Get statistics per retailer per day
#'
#' @return
#' @export
admin_stats_daily <- function() {
  url <- paste0(base_url(), "admin/stats/daily")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    select(date, retailer_id, count) %>%
    arrange(desc(date), retailer_id)
}
