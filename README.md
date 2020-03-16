
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
# Example API key. This key will not work.
#
API_KEY <- "5bed3ac9-6dc9-4926-aed8-8c97a7cb8057"

set_api_key(API_KEY)
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

## Retailers

Use `retailer()` to get a list of retailers.

``` r
retailer()
```

    # A tibble: 67 x 4
       retailer_id name             url                              currency
             <int> <chr>            <chr>                            <chr>   
     1           1 EEM Technologies https://www.eemtechnologies.com/ USD     
     2           2 Clicks           https://clicks.co.za/            ZAR     
     3           3 Dischem          https://www.dischem.co.za/       ZAR     
     4           4 Game             https://www.game.co.za/          ZAR     
     5           5 Woolworths       https://www.woolworths.co.za/    ZAR     
     6           6 Fortnum & Mason  https://www.fortnumandmason.com/ GBP     
     7           7 John Lewis       https://www.johnlewis.com/       GBP     
     8           8 Marks & Spencer  https://www.marksandspencer.com/ GBP     
     9           9 Pick 'n Pay      https://www.pnp.co.za/           ZAR     
    10          10 Makro            https://www.makro.co.za/         ZAR     
    # … with 57 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(45)
```

``` 
# A tibble: 1 x 4
  retailer_id name               url                         currency
        <int> <chr>              <chr>                       <chr>   
1          45 Builders Warehouse https://www.builders.co.za/ ZAR     
```

## Products

Get a list of products for a specific retailer.

``` r
retailer_products(9)
```

    # A tibble: 13,205 x 4
       product_id name                                    brand sku                 
            <int> <chr>                                   <lgl> <chr>               
     1    1193536 PnP Pasta Macaroni 1kg                  NA    000000000000683705_…
     2    1193566 RHODES STRAWBERRY JAM 600GR             NA    000000000000766985_…
     3    1193592 Kellogg's Bar Almond&cranberry 5x33gr   NA    000000000000740944_…
     4    1193595 Kellogg's Special K Bar Red Berry 5x25… NA    000000000000740819_…
     5    1193599 ROYAL BAKING POWDER TIN 200GR           NA    000000000000789523_…
     6    1193603 PnP Smoked Mussels Value Pack 5ea       NA    000000000000317314_…
     7    1193623 JUNGLE MUESLI MIXED BERRIES 750GR       NA    000000000000778781_…
     8    1193625 JUNGLE MUESLI MIXED BERRIES LITE 750GR  NA    000000000000778793_…
     9    1193630 JUNGLE OATSO EASY INS BANANA FLAV 500GR NA    000000000000778165_…
    10    1193631 NESTLE MILO CEREAL BAR MULTIPACK 6EA    NA    000000000000778182_…
    # … with 13,195 more rows

Information on a specific product.

``` r
item <- product(530290)
```

What fields are
available?

``` r
names(item)
```

``` 
[1] "product_id"  "retailer_id" "url"         "name"        "brand"      
[6] "sku"         "barcodes"   
```

Get product name,
[SKU](https://en.wikipedia.org/wiki/Stock_keeping_unit) and barcodes.

``` r
item$name
```

    [1] "Ola Rich 'n Creamy Magical Unicorn Ice Cream 1.8l"

``` r
item$sku
```

    [1] "000000000000777619_EA"

``` r
item$barcodes
```

    [1] "6001087378543"

## Price

Get price history data for a specific product.

``` r
product_prices(530290)
```

``` 
# A tibble: 6 x 5
  product_id time                      price price_promotion available
       <int> <chr>                     <dbl>           <dbl> <lgl>    
1     530290 2020-03-14T00:32:25+00:00  50.0            40.0 NA       
2     530290 2020-03-07T00:32:36+00:00  50.0            40.0 NA       
3     530290 2020-02-22T00:31:17+00:00  50.0            NA   NA       
4     530290 2020-02-15T00:32:47+00:00  50.0            38.0 NA       
5     530290 2020-02-08T00:32:37+00:00  50.0            38.0 NA       
6     530290 2020-02-01T00:34:24+00:00  50.0            45.0 NA       
```
