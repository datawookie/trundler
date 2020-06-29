#' List all categories
#'
#' @return Categories as a \code{data.frame}.
#' @export
categories <- function() {
  url <- paste0(base_url(), "category")
  response <- GET(url)

  check_response_error(response)
  check_response_json(response)

  result <- response %>%
    content(as = "text", encoding = "UTF-8") %>%
    fromJSON() %>%
    as_tibble()

  if (nrow(result)) {
    result %>%
      rename(category_id = id, category_parent_id = parent_id, category_label = label, category_path = path)
  } else {
    warning("There are currently no categories defined.", call. = FALSE)
    NULL
  }
}

#' Create graph of category hierarchy
#'
#' @return Categories as a \code{tbl_graph}.
#' @export
#'
#' @examples
#' library(ggraph)
#'
#' graph <- categories_graph()
#' # In principle there should be graph data available, but let's check.
#' if (!is.null(graph)) {
#'   ggraph(graph, 'tree') +
#'     geom_edge_link() +
#'     geom_node_point() +
#'     geom_node_label(aes(label = category_label)) +
#'     theme_graph()
#' }
categories_graph <- function() {
  taxonomy <- categories()

  if (is.null(taxonomy)) {
    NULL
  } else {
    taxonomy_nodes <- taxonomy %>% select(category_label)
    taxonomy_edges <- taxonomy %>%
      select(from = category_parent_id, to = category_id) %>%
      filter(!(is.na(from) | is.na(to)))

    tbl_graph(nodes = taxonomy_nodes, edges = taxonomy_edges)
  }
}

#' Products for a specific retailer
#'
#' @param category_id A category ID.
#' @param recursive Should all sub-categories be included?
#' @param ... Arguments passed through to \code{paginate()}.
#'
#' @return Details of all products for a specific category as a \code{data.frame}.
#' @export
#'
#' @examples
#' # Get products for a specific category.
#' \dontrun{
#' category_id = categories() %>% filter(category_label == "red wine") %>% pull(category_id)
#' category_products(category_id)
#' }
category_products <- function(category_id, recursive=TRUE, ...) {
  url <- paste0(base_url(), "category/%d") %>%
    sprintf(category_id)

  url <- param_set(url, key = "recursive", value = param_boolean(recursive))

  products <- paginate(url, ...)

  if (nrow(products)) {
    products %>%
      select(product_id = id, retailer_id, product, brand, model, sku)
  } else {
    message("No products are currently available for this category.")
    tibble(
      product_id = integer(),
      retailer_id = integer(),
      product = character(),
      brand = character(),
      model = character(),
      sku = character()
    )
  }
}
