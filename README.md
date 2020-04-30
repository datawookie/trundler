
<!-- README.md is generated from README.Rmd. Please edit that file -->

# trundler <img src="man/figures/trundler-hex.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/trundler.svg?branch=master)](https://travis-ci.org/datawookie/trundler)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/trundler.svg)](https://codecov.io/github/datawookie/trundler)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

``` r
library(trundler)
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

    # A tibble: 103 x 4
       retailer_id retailer         retailer_url                     currency
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
    # … with 93 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(45)
```

``` 
# A tibble: 1 x 4
  retailer_id retailer           retailer_url                currency
        <int> <chr>              <chr>                       <chr>   
1          45 Builders Warehouse https://www.builders.co.za/ ZAR     
```

## Products

Get a list of products for a specific retailer.

``` r
retailer_products(5)
```

    # A tibble: 86,321 x 5
       product_id product                         brand              model sku      
            <int> <chr>                           <chr>              <chr> <chr>    
     1    2591731 Soft Touch Bikinis 2 Pack       <NA>               <NA>  60092074…
     2     606751 Belted Chinos                   Woolworths Classi… <NA>  60092117…
     3     606756 Cropped Leggings                Woolworths Classi… <NA>  60092110…
     4     606804 Pure Cotton Towelling Nappies … <NA>               <NA>  60092149…
     5     607099 Best Baby Ever Cotton Blend T-… <NA>               <NA>  60092149…
     6     607120 DR. HAUSCHKA Night & Active Kit Dr. Hauschka       <NA>  40208290…
     7     607465 Non-slip Chrome Hangers 5-Pack  <NA>               <NA>  60091732…
     8     608276 Extra Depth & Length 144TC Cot… <NA>               <NA>  60092146…
     9     608341 144TC Cotton Blend Fitted Sheet <NA>               <NA>  60092146…
    10     608419 All Year Round Temperature Com… <NA>               <NA>  60091789…
    # … with 86,311 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, product = "coffee", brand = "nespresso")
```

    # A tibble: 5 x 5
      product_id product                                 brand    model sku         
           <int> <chr>                                   <chr>    <chr> <chr>       
    1     667365 NESPRESSO Essenza Mini Coffee Machine   Nespres… <NA>  76300396187…
    2     667426 NESPRESSO Citiz&Milk Coffee Machine     Nespres… <NA>  76300544309…
    3     667654 NESPRESSO Lattissima Touch Coffee Mach… Nespres… <NA>  76300476151…
    4     667815 NESPRESSO Lattissima One Coffee Machine Nespres… <NA>  76300396464…
    5     729093 NESPRESSO Creatista Plus Coffee Machine Nespres… <NA>  76300396488…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    # A tibble: 107 x 6
       product_id retailer_id product                   brand     model sku         
            <int>       <int> <chr>                     <chr>     <chr> <chr>       
     1    2247139          95 Dettol Spring Fresh Inst… <NA>      <NA>  10335419EA  
     2    2265399          95 Peppertree Waterless Han… <NA>      <NA>  10619401EA  
     3    2250059          95 Pepper Tree Hand Sanitis… <NA>      <NA>  10494425EA  
     4    2256663          95 Dettol Instant Hand Sani… <NA>      <NA>  10207865EA  
     5    2265497          95 Dettol Instant Hand Sani… <NA>      <NA>  10614438EA  
     6    2305837          88 Waterless Hand Sanitiser  CHARLOTT… <NA>  36327360    
     7    2305838          88 Waterless Hand Sanitiser  CHARLOTT… <NA>  36327379    
     8    2380059          30 Dr. Bronner's Lavender O… <NA>      <NA>  362030011   
     9    2339798           4 HAND SANITISER 50ML FLOR… DETTOL    50ML  00700660    
    10    2339368          10 Lifebuoy Hand Sanitiser … LIFEBUOY  <NA>  00000000038…
    # … with 97 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 177 x 6
       product_id retailer_id product                     brand    model  sku       
            <int>       <int> <chr>                       <chr>    <chr>  <chr>     
     1    2530360          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
     2    2423310          10 Nescafe Classic Coffee (1 … NESCAFE  <NA>   000000000…
     3    2480402          10 NESCAFE GOLD Cappuccino Co… NESCAFE… <NA>   000000000…
     4    2422180          10 Nescafe Esperta Capsule Co… NESCAFE  12397… 000000000…
     5    2530361          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
     6    2530372          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
     7    2530373          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
     8    2530374          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
     9    2530375          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
    10    2530376          10 Nescafe Dolce Gusto Coffee… NESCAFE  <NA>   000000000…
    # … with 167 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 947 x 6
       product_id retailer_id product                            brand  model sku   
            <int>       <int> <chr>                              <chr>  <chr> <chr> 
     1    2268492          47 "Hisense 203cm (80\") Laser TV- H… Hisen… <NA>  67939 
     2    2267838          47 "Hisense 124cm(49\") FHD TV - 49B… Hisen… <NA>  68557…
     3    2267839          47 "Samsung 81cm(32\") HD Smart TV -… Samsu… <NA>  64484 
     4    2267843          47 "Samsung 249cm(98\") QLED TV - QA… Samsu… <NA>  72123 
     5    2267844          47 "Samsung 81cm(32\") HD Smart TV -… Samsu… <NA>  64484 
     6    2268287          47 "Samsung 208cm(82\") Q900R QLED 8… Samsu… <NA>  67630 
     7    2268294          47 "Samsung 249cm(98\") QLED TV - QA… Samsu… <NA>  72123 
     8    2268313          47 "Samsung 208cm(82\") Q900R QLED 8… Samsu… <NA>  67630 
     9    2268534          47 "Hisense 165cm(65\") ULED Smart T… Hisen… <NA>  68546 
    10    2268585          47 "Hisense 124cm(49\") FHD TV - 49B… Hisen… <NA>  68557…
    # … with 937 more rows

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
[1] "product_id"  "retailer_id" "product_url" "product"     "brand"      
[6] "model"       "sku"         "barcodes"   
```

Get product name,
[SKU](https://en.wikipedia.org/wiki/Stock_keeping_unit) and barcodes.

``` r
item$product
```

    [1] "Ola Rich 'n Creamy Magical Unicorn Ice Cream 1.8l"

``` r
item$sku
```

    [1] "000000000000777619_EA"

``` r
item$barcodes
```

    [1] NA

## Price

Get price history data for a specific product.

``` r
product_prices(530290)
```

    # A tibble: 32 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-04-30 02:21:07  50.0            40.0            40.0
     2     530290 2020-04-29 02:21:04  50.0            40.0            40.0
     3     530290 2020-04-28 02:50:09  50.0            40.0            40.0
     4     530290 2020-04-27 01:55:26  50.0            40.0            40.0
     5     530290 2020-04-26 01:59:51  50.0            40.0            40.0
     6     530290 2020-04-25 02:00:59  50.0            40.0            40.0
     7     530290 2020-04-24 01:32:45  50.0            40.0            40.0
     8     530290 2020-04-23 02:09:10  50.0            40.0            40.0
     9     530290 2020-04-22 01:58:53  50.0            NA              50.0
    10     530290 2020-04-21 02:00:44  50.0            NA              50.0
    # … with 22 more rows, and 1 more variable: available <lgl>
