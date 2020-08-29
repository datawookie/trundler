
<!-- README.md is generated from README.Rmd. Please edit that file -->

# trundler <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/trundler.svg?branch=master)](https://travis-ci.org/datawookie/trundler)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/trundler.svg)](https://codecov.io/github/datawookie/trundler)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

The homepage for the {trundler} R package is at
<https://datawookie.github.io/trundler/>.

## Installation

Install from GitHub.

``` r
remotes::install_github("datawookie/trundler")
```

## Usage

``` r
library(trundler)
```

Check version.

``` r
packageVersion("trundler")
```

    [1] '0.1.5'

### Set API Key

To access the full API you’ll need to first specify an API key.

``` r
# Example API key (this key will not work).
#
set_api_key("5bed3ac9-6dc9-4926-aed8-8c97a7cb8057")
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

You can also subscribe via
[RapidAPI](https://rapidapi.com/datawookie/api/trundler), in which case
you use a different function to register your key.

``` r
set_rapidapi_key("5a1ae0ce24mshd483dae6ab7308dp129ef6jsn1f473053d6b0")
```

### Retailers

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

### Products

Get a list of products for a specific retailer.

``` r
retailer_products(5)
```

    # A tibble: 92,284 x 5
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
    # … with 92,274 more rows

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

    # A tibble: 126 x 6
       product_id retailer_id product                     brand     model sku       
            <int>       <int> <chr>                       <chr>     <chr> <chr>     
     1    2121127          63 Kids Waterless Hand Saniti… Handtizer <NA>  KID330    
     2    1427238           5 CHARLOTTE RHYS St Thomas W… Charlott… <NA>  606110261…
     3    1753347          63 Waterless Hand Sanitiser -… Charlott… <NA>  FCR075HAN…
     4    1753348          63 Waterless Hand Sanitiser -… Charlott… <NA>  FCR300WHS 
     5    1782558           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     6    1782566           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     7    1782675           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     8    1782684           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     9    2121135          63 Waterless Hand Sanitiser -… Handtizer <NA>  HAND330   
    10    2265497          95 Dettol Instant Hand Saniti… <NA>      <NA>  10614438EA
    # … with 116 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 179 x 6
       product_id retailer_id product                      brand     model sku      
            <int>       <int> <chr>                        <chr>     <chr> <chr>    
     1    1515084          13 Nescafe Original Instant Co… NESCAFE   <NA>  254889601
     2    1471626          35 NESPRESSO Magimix CitiZ & M… NESPRESSO <NA>  311-8204…
     3    1492620          13 Nescafe Original Decaffeina… NESCAFE   <NA>  254889371
     4    1513042          13 Nescafe Dolce Gusto Preludi… NESCAFE … <NA>  296837064
     5    1486019          13 Nescafe Dolce Gusto Cafe Au… NESCAFE … <NA>  301217353
     6    1486026          13 Nescafe Dolce Gusto America… NESCAFE … <NA>  266292846
     7    1492565          13 Nescafe Original Decaffeina… NESCAFE   <NA>  254889388
     8    1492555          13 Nescafe Black Gold Instant … NESCAFE   <NA>  297876954
     9    1486022          13 Nescafe Dolce Gusto Flat Wh… NESCAFE … <NA>  301217330
    10    1486010          13 Nescafe Dolce Gusto America… NESCAFE … <NA>  276686404
    # … with 169 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 954 x 6
       product_id retailer_id product                          brand  model sku     
            <int>       <int> <chr>                            <chr>  <chr> <chr>   
     1    1417977          51 "Samsung 49\" UA49RU7100 LED UH… Samsu… <NA>  UA49RU7…
     2    1417983          51 "Samsung 55\" QA55Q60RAK QLED 4… Samsu… <NA>  QA55Q60…
     3    1417984          51 "Samsung 65” QA65Q60RAK QLED UH… Samsu… <NA>  QA65Q60…
     4    1417987          51 "Samsung 65” QA65Q900RBK QLED 8… Samsu… <NA>  QA65Q90…
     5    1417988          51 "Samsung 65\" QA65Q70RAK QLED U… Samsu… <NA>  QA65Q70…
     6    1417989          51 "Samsung 65\" QA65Q80RAK QLED U… Samsu… <NA>  QA65Q80…
     7    1417991          51 "Samsung 75\" QA75Q60R QLED UHD… Samsu… <NA>  QA75Q60R
     8    1418018          51 "Samsung 82” Q60R QLED UHD Smar… Samsu… <NA>  QA82Q60 
     9    1418021          51 "Samsung 40” N5000 LED FHD Tv"   Samsu… <NA>  UA40N50…
    10    1418023          51 "Samsung 49” N5000 LED FHD Tv"   Samsu… <NA>  UA49N50…
    # … with 944 more rows

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

### Prices

Get price history data for a specific product.

``` r
product_prices(530290)
```

    # A tibble: 41 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-05-10 03:23:38  50.0            40.0            40.0
     2     530290 2020-05-09 02:56:09  50.0            40.0            40.0
     3     530290 2020-05-08 01:36:36  50.0            40.0            40.0
     4     530290 2020-05-06 03:06:50  50.0            40.0            40.0
     5     530290 2020-05-05 01:34:16  50.0            40.0            40.0
     6     530290 2020-05-04 02:56:37  50.0            40.0            40.0
     7     530290 2020-05-03 03:01:05  50.0            40.0            40.0
     8     530290 2020-05-02 04:27:22  50.0            40.0            40.0
     9     530290 2020-05-01 02:20:50  50.0            40.0            40.0
    10     530290 2020-04-30 02:21:07  50.0            40.0            40.0
    # … with 31 more rows, and 1 more variable: available <lgl>
