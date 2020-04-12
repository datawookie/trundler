#' Information on all API keys
#'
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
#' @export
admin_stats <- function() {
  url <- paste0(base_url(), "admin/stats")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    rename(stats_id = id) %>%
    mutate(
      start_time = as.POSIXct(strptime(start_time, "%Y-%m-%dT%H:%M:%S", tz = "UTC")),
      finish_time = as.POSIXct(strptime(finish_time, "%Y-%m-%dT%H:%M:%S", tz = "UTC"))
    )
}

#' Get status statistics per crawl
#'
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
#' @export
admin_stats_daily <- function() {
  url <- paste0(base_url(), "admin/stats/daily")

  response <- GET(url, add_headers("X-Api-Key" = get_api_key()))

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    select(date, retailer_id, count) %>%
    mutate(date = as.Date(date)) %>%
    arrange(desc(date), retailer_id)
}
