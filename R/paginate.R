#' Paginate results from API
#'
#' Ideas for improvement:
#'
#' - Paginated endpoints return a 'X-Total-Count' header record with the total number of records. This could be used
#'   to pre-allocate space and avoid the while() loop. First call to endpoint could have limit=0 to avoid retrieving
#'   any results.
#' - Move the JSON processing outside of the loop. Just accumulate all of the JSON into a single document. Evaluate
#'   whether this is an improvement!
#' - Use HEAD to find expected number of results.
#' - Could avoid final API query by checking if the number of results returned was less than limit.
#'
#' @param url API endpoint
#' @param limit Number of items per query
#' @param verbose Whether to produce verbose output.
paginate <- function(url, limit = 10000, verbose = FALSE) {
  offset = 0
  results <- list()

  while(TRUE) {
    response <- GET(
      sprintf("%s?limit=%d&offset=%d", url, limit, offset),
      UA,
      add_headers("X-Api-Key" = get_api_key())
    )

    # Check for "204 NO CONTENT".
    #
    if (response$status_code == 204) break

    check_response_error(response)
    check_response_json(response)

    result <- response %>%
      content(as = "text", encoding = "UTF-8") %>%
      fromJSON()

    if (verbose) {
      message(sprintf("Retrieved %d results.", nrow(result)))
    }

    results <- c(results, list(result))

    offset = offset + limit
  }

  do.call(rbind, results) %>%
    as_tibble()
}
