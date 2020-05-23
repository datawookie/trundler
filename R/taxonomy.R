#' List all categories
#'
#' @return Categories as a \code{data.frame}.
#' @export
categories <- function() {
  url <- paste0(base_url(), "category")
  response <- GET(url)

  check_response_error(response)
  check_response_json(response)

  response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble() %>%
  rename(category_id = id, parent_category_id = parent_id)
}

#' Products for a specific retailer
#'
#' @param category_id A category ID.
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Details of all products for a specific category as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get products for a specific category.
#' \dontrun{
#' category_id = categories() %>% filter(label == "red wine") %>% pull(category_id)
#' category_products(category_id)
#' }
category_products <- function(category_id, ...) {
  url <- paste0(base_url(), "category/%d") %>%
    sprintf(category_id)

  products <- paginate(url, ...)

  if (nrow(products)) {
    products %>%
      rename(product_id = id) %>%
      mutate(category_id = category_id) %>%
      select(category_id, product_id, retailer_id, product, brand, model, sku)
  } else {
    message("No products are currently available for this category.")
    tibble(
      category_id = integer(),
      product_id = integer(),
      retailer_id = integer(),
      product = character(),
      brand = character(),
      model = character(),
      sku = character()
    )
  }
}
