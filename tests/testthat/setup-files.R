# Avoid timedatectl warning in tests?
#
Sys.setenv(TZ = "Etc/UTC")

library(RPostgres)
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
  SQL <- glue("SELECT product.id FROM price INNER JOIN product ON price.product_id = product.id INNER JOIN retailer ON retailer.id = product.retailer_id WHERE {where} AND visible GROUP BY product.id, product.brand, product.sku LIMIT 1;")

  db_fetch_query(SQL)$id
}
db_get_retailer <- function(where) {
  SQL <- glue("SELECT retailer.id FROM retailer WHERE visible LIMIT 1;")

  db_fetch_query(SQL)$id
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
  db <- dbConnect(
    Postgres(),
    dbname = DB_DATABASE,
    host = DB_HOST,
    user = DB_USER,
    password = DB_PASSWD
  )
  on.exit(dbDisconnect(db))

  db_send_statement("set search_path to prd, public;")

  retailer_id           <- db_get_retailer()

  product_id            <- db_get_product("TRUE")
  product_id_null_brand <- db_get_product("brand IS NULL")
  product_id_null_sku   <- db_get_product("sku IS NULL")
}
