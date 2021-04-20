# Avoid timedatectl warning in tests?
#
Sys.setenv(TZ = "Etc/UTC")

library(glue)

TRUNDLER_KEY = Sys.getenv("TRUNDLER_KEY")
RAPIDAPI_KEY = Sys.getenv("RAPIDAPI_KEY")

base_url_original <- base_url()

DB_HOST = Sys.getenv("DB_HOST")
DB_DATABASE = Sys.getenv("DB_DATABASE")
DB_USER = Sys.getenv("DB_USER")
DB_PASSWD = Sys.getenv("DB_PASSWD")

db_fetch_query <- function(sql) {
  result <- dbSendQuery(db, sql)
  data <- dbFetch(result)
  dbClearResult(result)

  data
}
db_send_statement <- function(sql) {
  dbClearResult(dbSendStatement(db, sql))
}

db_get_product <- function(where) {
  SQL <- glue("SELECT product.id FROM price INNER JOIN product ON price.product_id = product.id INNER JOIN retailer ON retailer.id = product.retailer_id WHERE {where} AND retailer.visible GROUP BY product.id, product.brand, product.sku LIMIT 1;")

  db_fetch_query(SQL)$id
}
db_get_retailer <- function() {
  RETAILER = "Yuppiechef"
  PRODUCT = "Classic Decorating Knife"
  BRAND = "Wusthof"

  SQL <- glue("SELECT retailer.id, product.product, product.brand FROM retailer INNER JOIN product ON retailer.id = product.retailer_id WHERE retailer = '{RETAILER}' AND product = '{PRODUCT}' AND brand = '{BRAND}' LIMIT 1;")

  db_fetch_query(SQL)
}

db_retailer_no_products <- function() {
  SQL <- glue("SELECT retailer.id FROM retailer LEFT JOIN product ON retailer.id = product.retailer_id WHERE NOT visible AND retailer_id IS NULL LIMIT 1;")

  db_fetch_query(SQL)$id
}

db_retailer_product_count <- function() {
  SQL <- glue("SELECT count(*), retailer_id FROM product GROUP BY retailer_id HAVING count(*) > 10000 LIMIT 1;")

  db_fetch_query(SQL)
}

# Use on_cran() to check if we are running on CRAN.
#
# If you are not CRAN (which applies to most of us), then you need to set an environment variable:
#
# NOT_CRAN=true
#
# These feels rather weird, like guilty until proven innocent, but it should work.
#
if (!testthat:::on_cran()) {
  # Conditionally include RPostgres because it was generating error (unavailable) on CRAN for r-patched-solaris-x86.
  library(RPostgres)

  db <- dbConnect(
    Postgres(),
    dbname = DB_DATABASE,
    host = DB_HOST,
    user = DB_USER,
    password = DB_PASSWD
  )
  on.exit(dbDisconnect(db))

  db_send_statement("set search_path to prd, public;")

  retailer_id           <- db_get_retailer()$id
  retailer_brand        <- db_get_retailer()$brand
  retailer_product      <- db_get_retailer()$product

  retailer_no_products  <- db_retailer_no_products()

  retailer_product_count <- db_retailer_product_count()$count
  retailer_product_count_id <- db_retailer_product_count()$retailer_id

  product_id            <- db_get_product("TRUE")
  product_id_null_brand <- db_get_product("brand IS NULL")
  product_id_null_sku   <- db_get_product("sku IS NULL")
}
