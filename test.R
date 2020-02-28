library(retail)

set_api_server("0.0.0.0", 8080)
retail:::base_url()

API_KEY = "5bed3ac9-6dc9-4926-aed8-8c97a7cb8057"
# API_KEY = Sys.getenv("RETAIL_KEY")

retailer()

set_api_key(API_KEY)
get_api_key()

# retailer(1)
#
# retailer_products(1)
# retailer_products(42)
product(21327)
# product_prices(18355)

# product_prices(11825)
