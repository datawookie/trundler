
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

    # A tibble: 71 x 4
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
    # … with 61 more rows

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
retailer_products(5)
```

    # A tibble: 64,602 x 5
       product_id name                            brand              model sku      
            <int> <chr>                           <chr>              <chr> <chr>    
     1     606751 Belted Chinos                   Woolworths Classi… <NA>  60092117…
     2     606756 Cropped Leggings                Woolworths Classi… <NA>  60092110…
     3     606804 Pure Cotton Towelling Nappies … <NA>               <NA>  60092149…
     4     607099 Best Baby Ever Cotton Blend T-… <NA>               <NA>  60092149…
     5     607120 DR. HAUSCHKA Night & Active Kit Dr. Hauschka       <NA>  40208290…
     6     607465 Non-slip Chrome Hangers 5-Pack  <NA>               <NA>  60091732…
     7     608276 Extra Depth & Length 144TC Cot… <NA>               <NA>  60092146…
     8     608341 144TC Cotton Blend Fitted Sheet <NA>               <NA>  60092146…
     9     608419 All Year Round Temperature Com… <NA>               <NA>  60091789…
    10     609106 Floral Cotton Rich Socks        <NA>               <NA>  60092149…
    # … with 64,592 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, name = "coffee", brand = "nespresso")
```

    # A tibble: 5 x 5
      product_id name                                   brand     model sku         
           <int> <chr>                                  <chr>     <chr> <chr>       
    1     667365 NESPRESSO Essenza Mini Coffee Machine  Nespresso <NA>  76300396187…
    2     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespresso <NA>  76300544309…
    3     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespresso <NA>  76300476151…
    4     667815 NESPRESSO Lattissima One Coffee Machi… Nespresso <NA>  76300396464…
    5     729093 NESPRESSO Creatista Plus Coffee Machi… Nespresso <NA>  76300396488…

A similar search can be applied across *all* retailers.

``` r
products(name = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 101 x 6
       product_id retailer_id name                         brand   model sku        
            <int>       <int> <chr>                        <chr>   <chr> <chr>      
     1     197759          28 Nespresso Vertuo Plus Coffe… Nespre… <NA>  798806     
     2     477109          10 Nespresso Lattissima Touch … NESPRE… <NA>  0000000000…
     3     459419          10 Nescafe Dolce Gusto Coffee … NESCAFE <NA>  0000000002…
     4     459494          10 NESCAFE Ricoffy Coffee Deca… NESCAFE <NA>  0000000000…
     5     459497          10 NESCAFE Dolce Gusto Coffee … NESCAFE <NA>  0000000002…
     6     459541          10 NESCAFE Gold Coffee Blend S… NESCAFE <NA>  0000000000…
     7     459652          10 NESCAFE Coffee Jar Gold Dec… NESCAFE <NA>  0000000003…
     8     459658          10 Nescafe Coffee Espresso (6 … NESCAFE <NA>  0000000003…
     9     459665          10 Nescafe Coffee Alta Rica (6… NESCAFE <NA>  0000000003…
    10     459710          10 Nescafe Dolce Gusto Coffee … NESCAFE <NA>  0000000002…
    # … with 91 more rows

``` r
products(name = "tv", brand = "samsung|hisense")
```

    # A tibble: 572 x 6
       product_id retailer_id name                     brand  model     sku         
            <int>       <int> <chr>                    <chr>  <chr>     <chr>       
     1     332220          10 "Samsung 70\" (179 cm) … SAMSU… 70RU7100… 00000000000…
     2     331236          10 "Samsung 190 cm (75\") … SAMSU… QA75Q900… 00000000000…
     3     331238          10 "Hisense 70\" (177cm) S… HISEN… 70B7100UW 00000000000…
     4     331256          10 "Samsung 163 cm (65\") … SAMSU… UA65RU73… 00000000000…
     5     331271          10 "Hisense 139 cm (55\") … HISEN… 55Q8600U… 00000000000…
     6     331613          10 "HISENSE 108 cm (43\") … HISEN… 43B7100   00000000000…
     7     331616          10 "HISENSE 139 cm (55\") … HISEN… 55B7100W  00000000000…
     8     331617          10 "HISENSE 80 cm (32\") S… HISEN… 32B6000HW 00000000000…
     9     331620          10 "SAMSUNG 208 cm (82\") … SAMSU… QA82Q90R… 00000000000…
    10     331622          10 "Samsung 208 cm (82\") … SAMSU… QA82Q60R… 00000000000…
    # … with 562 more rows

Information on a specific product.

``` r
item <- product(530290)
```

What fields are available?

``` r
names(item)
```

``` 
[1] "product_id"  "retailer_id" "url"         "name"        "brand"      
[6] "model"       "sku"         "barcodes"   
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
# A tibble: 8 x 5
  product_id time                      price price_promotion available
       <int> <chr>                     <dbl>           <dbl> <lgl>    
1     530290 2020-03-22T03:38:30+00:00  50.0            40.0 NA       
2     530290 2020-03-21T01:50:25+00:00  50.0            40.0 NA       
3     530290 2020-03-14T00:32:25+00:00  50.0            40.0 NA       
4     530290 2020-03-07T00:32:36+00:00  50.0            40.0 NA       
5     530290 2020-02-22T00:31:17+00:00  50.0            NA   NA       
6     530290 2020-02-15T00:32:47+00:00  50.0            38.0 NA       
7     530290 2020-02-08T00:32:37+00:00  50.0            38.0 NA       
8     530290 2020-02-01T00:34:24+00:00  50.0            45.0 NA       
```
