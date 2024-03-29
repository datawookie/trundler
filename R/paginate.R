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
#' @param head Return the data (\code{FALSE}) or the number of records (\code{TRUE})?
#' @param verbose Whether to produce verbose output.
paginate <- function(url, head = FALSE, limit = 100000, verbose = NULL) {
  offset <- 0
  results <- list()

  if (is.null(verbose)) verbose <- trundler_chatty()

  if (!head) {
    while (TRUE) {
      url <- url %>%
        # Prevent converting to scientific notation because "+" has different meaning in URL.
        param_set(key = "limit", value = format(limit, scientific = FALSE)) %>%
        param_set(key = "offset", value = format(offset, scientific = FALSE))

      response <- GET(url)

      # Check for "204 NO CONTENT".
      #
      if (response$status_code == 204) break

      check_response_error(response)
      check_response_json(response)

      if (offset == 0) {
        count_result <- as.integer(response$headers$`x-total-count`)
        if (length(count_result)) {
          count_page <- ceiling(count_result / limit)
          if (verbose) message(glue("Retrieving {count_result} results ({count_page} pages)."))
          #
          stepper <- progressr::progressor(steps = count_page, auto_finish = FALSE)
        } else {
          stepper <- NULL
        }
      }

      result <- response %>%
        content(as = "text", encoding = "UTF-8") %>%
        fromJSON()

      if (verbose) message(sprintf("Retrieved %d results.", nrow(result)))

      if (!length(result)) {
        if (verbose) message("No more rows.")
        break
      }

      results <- c(results, list(result))

      if (nrow(result) < limit) {
        if (verbose) message("Received fewer rows than requested.")
        break
      }

      offset <- offset + limit
      # Increment progress bar.
      stepper()
    }

    do.call(rbind, results) %>%
      as_tibble() %>%
      mutate_at(vars(any_of(c("brand", "model", "sku"))), as.character) %>%
      mutate_at(vars(any_of(c("price", "price_promotion"))), as.numeric) %>%
      mutate_at(vars(any_of(c("time"))), function(time) {
        as.POSIXct(time, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC")
      })
  } else {
    response <- HEAD(url)

    check_response_error(response)

    as.integer(response$headers$`x-total-count`)
  }
}
