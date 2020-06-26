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
#' @param head Should the query return the data (head = FALSE) or the number of records that would be returned (head = TRUE)?
#' @param verbose Whether to produce verbose output.
paginate <- function(url, head = FALSE, limit = 10000, verbose = FALSE) {
  offset = 0
  results <- list()

  if (!head) {
    while(TRUE) {
      url <- url %>%
        param_set(key = "limit", value = limit) %>%
        # Prevent converting to scientific notation because "+" has different meaning in URL.
        param_set(key = "offset", value = format(offset, scientific = FALSE))

      response <- GET(url)

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

      if (!length(result)) {
        if (verbose) message("No more rows.")
        break
      }

      results <- c(results, list(result))

      if (nrow(result) < limit) {
        if (verbose) message("Received fewer rows than requested.")
        break
      }

      offset = offset + limit
    }

    do.call(rbind, results) %>%
      as_tibble() %>%
      mutate_at(vars(any_of(c("brand", "model", "sku"))), as.character) %>%
      mutate_at(vars(any_of(c("price", "price_promotion"))), as.numeric) %>%
      mutate_at(vars(any_of(c("time"))), function(time) {as.POSIXct(time, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")})
  } else {
    response <- HEAD(url)

    if (response$status_code == 204) break

    check_response_error(response)

    as.numeric(response$headers$`x-total-count`)
  }

}
