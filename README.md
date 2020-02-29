
<!-- README.md is generated from README.Rmd. Please edit that file -->

# retail <img src="man/figures/retail-hex.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/retail.svg?branch=master)](https://travis-ci.org/datawookie/retail)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/retail.svg)](https://codecov.io/github/datawookie/retail)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

``` r
library(retail)
```

## Set API Key

To access the full API you’ll need to first specify an API key.

``` r
# Example API key.
#
API_KEY <- "8f9f6c4e-5dd6-4bff-352c-592b35cf2437"

set_api_key(API_KEY)
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

## Retailers

Use `retailer()` to get a list of retailers.

``` r
retailer()
```

    # A tibble: 63 x 4
          id name             url                              currency
       <int> <chr>            <chr>                            <chr>   
     1     1 EEM Technologies https://www.eemtechnologies.com/ USD     
     2     2 Clicks           https://clicks.co.za/            ZAR     
     3     3 Dischem          https://www.dischem.co.za/       ZAR     
     4     4 Game             https://www.game.co.za/          ZAR     
     5     5 Woolworths       https://www.woolworths.co.za/    ZAR     
     6     6 Fortnum & Mason  https://www.fortnumandmason.com/ GBP     
     7     7 John Lewis       https://www.johnlewis.com/       GBP     
     8     8 Marks & Spencer  https://www.marksandspencer.com/ GBP     
     9     9 Pick 'n Pay      https://www.pnp.co.za/           ZAR     
    10    10 Makro            https://www.makro.co.za/         ZAR     
    # … with 53 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(45)
```

``` 
# A tibble: 1 x 4
     id name               url                         currency
  <int> <chr>              <chr>                       <chr>   
1    45 Builders Warehouse https://www.builders.co.za/ ZAR     
```

## Products

Get a list of products for a specific retailer.

``` r
retailer_products(9)
```

    # A tibble: 12,543 x 4
           id name                                         brand sku                
        <int> <chr>                                        <lgl> <chr>              
     1 531906 Band-aid Clear Plaster Strip s 25            NA    000000000000247606…
     2 531907 Rennie Peppermint Antacid Tablets 48s        NA    000000000000251026…
     3 531908 Dettol Antiseptic Liquid 125ml               NA    000000000000244558…
     4 531911 Disprin Regular Pain Tablets 12ea            NA    000000000000244500…
     5 531912 Panado Pain And Fever Tablets 2ea            NA    000000000000240818…
     6 531914 Dettol Antiseptic Liquid 50ml                NA    000000000000233057…
     7 531915 Vicks Acta Plus Cough Syrup 50ml             NA    000000000000232931…
     8 531917 Woods Great Peppermint Cure Cough Remedy 10… NA    000000000000238698…
     9 531919 Zam-buk Herbal Balm 60g                      NA    000000000000237642…
    10 531920 Grand-pa Headache Tablets 10ea               NA    000000000000242053…
    # … with 12,533 more rows

Information on a specific product.

``` r
ice_cream <- product(530290)
```

What fields are
available?

``` r
names(ice_cream)
```

``` 
[1] "id"          "retailer_id" "url"         "name"        "brand"      
[6] "sku"         "barcodes"   
```

Get product name,
[SKU](https://en.wikipedia.org/wiki/Stock_keeping_unit) and barcodes.

``` r
ice_cream$name
```

    [1] "Ola Rich 'n Creamy Magical Unicorn Ice Cream 1.8l"

``` r
ice_cream$sku
```

    [1] "000000000000777619_EA"

``` r
ice_cream$barcodes
```

    [1] "6001087378543"

## Price

Get price history data for a specific product.

``` r
product_prices(530290)
```

``` 
# A tibble: 4 x 5
  product_id time                      price price_promotion available
       <int> <chr>                     <dbl>           <dbl> <lgl>    
1     530290 2020-02-22T00:31:17+00:00  50.0            NA   NA       
2     530290 2020-02-15T00:32:47+00:00  50.0            38.0 NA       
3     530290 2020-02-08T00:32:37+00:00  50.0            38.0 NA       
4     530290 2020-02-01T00:34:24+00:00  50.0            45.0 NA       
```
