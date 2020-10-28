context("taxonomy")

test_that("categories", {
  skip_on_cran()

  expect_error(categories(1), NA)
  last_category <- categories(1)
  expect_equal(names(last_category), c("category_id", "category_parent_id", "category_label", "category_path"))
})

test_that("categories graph", {
  skip_on_cran()

  expect_error(categories_graph(), NA)
  expect_equal(class(categories_graph()), c("tbl_graph", "igraph"))
})

test_that("category products", {
  skip_on_cran()

  expect_equal(names(category_products(85)), c("product_id", "retailer_id", "product", "brand", "model", "sku"))
})

test_that("invalid category", {
  skip_on_cran()

  expect_error(category_products(0))
})

