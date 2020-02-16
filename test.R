library(retail)

retailer()

set_api_key(Sys.getenv("RETAIL_KEY"))
get_api_key()

retailer(1)

retailer_products(1)
product(11825)
product_prices(11825)
