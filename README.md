
<!-- README.md is generated from README.Rmd. Please edit that file -->

# retail <img src="man/figures/retail-hex.png" align="right" alt="" width="120" />

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
       <fct>       <chr>            <chr>                            <chr>   
     1 1           EEM Technologies https://www.eemtechnologies.com/ USD     
     2 2           Clicks           https://clicks.co.za/            ZAR     
     3 3           Dischem          https://www.dischem.co.za/       ZAR     
     4 4           Game             https://www.game.co.za/          ZAR     
     5 5           Woolworths       https://www.woolworths.co.za/    ZAR     
     6 6           Fortnum & Mason  https://www.fortnumandmason.com/ GBP     
     7 7           John Lewis       https://www.johnlewis.com/       GBP     
     8 8           Marks & Spencer  https://www.marksandspencer.com/ GBP     
     9 9           Pick 'n Pay      https://www.pnp.co.za/           ZAR     
    10 10          Makro            https://www.makro.co.za/         ZAR     
    # … with 93 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(45)
```

``` 
# A tibble: 1 x 4
  retailer_id retailer           retailer_url                currency
  <fct>       <chr>              <chr>                       <chr>   
1 45          Builders Warehouse https://www.builders.co.za/ ZAR     
```

## Products

Get a list of products for a specific retailer.

``` r
retailer_products(5)
```

    # A tibble: 85,975 x 5
       product_id product                         brand              model sku      
       <fct>      <chr>                           <chr>              <chr> <chr>    
     1 2591731    Soft Touch Bikinis 2 Pack       <NA>               <NA>  60092074…
     2 606751     Belted Chinos                   Woolworths Classi… <NA>  60092117…
     3 606756     Cropped Leggings                Woolworths Classi… <NA>  60092110…
     4 606804     Pure Cotton Towelling Nappies … <NA>               <NA>  60092149…
     5 607099     Best Baby Ever Cotton Blend T-… <NA>               <NA>  60092149…
     6 607120     DR. HAUSCHKA Night & Active Kit Dr. Hauschka       <NA>  40208290…
     7 607465     Non-slip Chrome Hangers 5-Pack  <NA>               <NA>  60091732…
     8 608276     Extra Depth & Length 144TC Cot… <NA>               <NA>  60092146…
     9 608341     144TC Cotton Blend Fitted Sheet <NA>               <NA>  60092146…
    10 608419     All Year Round Temperature Com… <NA>               <NA>  60091789…
    # … with 85,965 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, product = "coffee", brand = "nespresso")
```

    # A tibble: 5 x 5
      product_id product                                 brand    model sku         
      <fct>      <chr>                                   <chr>    <chr> <chr>       
    1 667365     NESPRESSO Essenza Mini Coffee Machine   Nespres… <NA>  76300396187…
    2 667426     NESPRESSO Citiz&Milk Coffee Machine     Nespres… <NA>  76300544309…
    3 667654     NESPRESSO Lattissima Touch Coffee Mach… Nespres… <NA>  76300476151…
    4 667815     NESPRESSO Lattissima One Coffee Machine Nespres… <NA>  76300396464…
    5 729093     NESPRESSO Creatista Plus Coffee Machine Nespres… <NA>  76300396488…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    # A tibble: 107 x 6
       product_id retailer_id product                   brand     model sku         
       <fct>      <fct>       <chr>                     <chr>     <chr> <chr>       
     1 1385527    9           LIFEBUOY HAND SANITISER … <NA>      <NA>  00000000000…
     2 1385530    9           LIFEBUOY HAND SANITISER … <NA>      <NA>  00000000000…
     3 1386565    9           LIFEBUOY HAND SANITISER … <NA>      <NA>  00000000000…
     4 1403656    5           BATH TIME Hand Sanitiser  W Bath&B… <NA>  60092112752…
     5 2247139    95          Dettol Spring Fresh Inst… <NA>      <NA>  10335419EA  
     6 1753347    63          Waterless Hand Sanitiser… Charlott… <NA>  FCR075HANDSA
     7 1753348    63          Waterless Hand Sanitiser… Charlott… <NA>  FCR300WHS   
     8 1782558    3           Aquashield Hand Sanitise… <NA>      <NA>  00000000000…
     9 1782566    3           Aquashield Hand Sanitise… <NA>      <NA>  00000000000…
    10 1782675    3           Aquashield Hand Sanitise… <NA>      <NA>  00000000000…
    # … with 97 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 177 x 6
       product_id retailer_id product                       brand       model sku   
       <fct>      <fct>       <chr>                         <chr>       <chr> <chr> 
     1 1515084    13          Nescafe Original Instant Cof… NESCAFE     <NA>  25488…
     2 1486022    13          Nescafe Dolce Gusto Flat Whi… NESCAFE DO… <NA>  30121…
     3 1486010    13          Nescafe Dolce Gusto American… NESCAFE DO… <NA>  27668…
     4 1486025    13          Nescafe Dolce Gusto Cafe Au … NESCAFE DO… <NA>  28210…
     5 1486050    13          Nescafe Original Instant Cof… NESCAFE     <NA>  25488…
     6 1486060    13          Nescafe Gold Blend Instant C… NESCAFE     <NA>  29733…
     7 1486041    13          Nescafe Cap Colombie Coffee … NESCAFE     <NA>  29786…
     8 1486043    13          Nescafe Alta Rica Instant Co… NESCAFE     <NA>  29811…
     9 1486065    13          Nescafe Gold Crema Instant C… NESCAFE     <NA>  27451…
    10 1486063    13          Nescafe Barista Gold Blend S… NESCAFE     <NA>  27934…
    # … with 167 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 947 x 6
       product_id retailer_id product                           brand  model sku    
       <fct>      <fct>       <chr>                             <chr>  <chr> <chr>  
     1 1417643    51          "Samsung Ua32n5300 LED TV 32 inc… Samsu… <NA>  UA32N5…
     2 1401154    47          "Hisense 81cm (32\") HD TV - 32N… Hisen… <NA>  68559  
     3 1402235    47          "Samsung 49\" UHD TV - UA49RU710… Samsu… <NA>  67652S…
     4 1402240    47          "Samsung 147cm(58\") UHD 4K Flat… Samsu… <NA>  67648S…
     5 1402243    47          "Samsung 109cm(43\") UHD 4K Flat… Samsu… <NA>  67653  
     6 1402246    47          "Hisense 81cm (32\") HD TV - 32N… Hisen… <NA>  68559  
     7 1402267    47          "Samsung 139cm(55\") UHD TV - UA… Samsu… <NA>  67650  
     8 1417371    51          "Samsung LED 49\" Curved UHD Sma… Samsu… <NA>  UA49RU…
     9 1417647    51          "Samsung 82” UA82RU8000 LED UHD … Samsu… <NA>  UA82RU…
    10 1417667    51          "Samsung 55\" UA55RU7300 LED UHD… Samsu… <NA>  UA55RU…
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

    # A tibble: 32 x 5
       product_id time                price price_promotion available
       <fct>      <dttm>              <dbl>           <dbl> <lgl>    
     1 530290     2020-04-30 02:21:07  50.0            40.0 NA       
     2 530290     2020-04-29 02:21:04  50.0            40.0 NA       
     3 530290     2020-04-28 02:50:09  50.0            40.0 NA       
     4 530290     2020-04-27 01:55:26  50.0            40.0 NA       
     5 530290     2020-04-26 01:59:51  50.0            40.0 NA       
     6 530290     2020-04-25 02:00:59  50.0            40.0 NA       
     7 530290     2020-04-24 01:32:45  50.0            40.0 NA       
     8 530290     2020-04-23 02:09:10  50.0            40.0 NA       
     9 530290     2020-04-22 01:58:53  50.0            NA   NA       
    10 530290     2020-04-21 02:00:44  50.0            NA   NA       
    # … with 22 more rows
