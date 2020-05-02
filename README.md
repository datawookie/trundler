
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

Check version.

``` r
packageVersion("trundler")
```

    [1] '0.1.2'

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

    # A tibble: 87,290 x 5
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
    # … with 87,280 more rows

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

    # A tibble: 109 x 6
       product_id retailer_id product                      brand     model sku      
            <int>       <int> <chr>                        <chr>     <chr> <chr>    
     1     820722          33 Stuf Hand Sanitiser 50ml Tu… Stuf      <NA>  <NA>     
     2     763695           3 Dettol Hand Sanitiser 200ml  Dettol    <NA>  00000000…
     3     806750           5 FRESH DELIGHTS Hand Sanitis… W Bath&B… <NA>  60092112…
     4     906277          63 Herbal Hand Sanitiser, 30ml  The Apot… <NA>  TA021    
     5     864780          19 Nilaqua Alcohol Free Hand S… Waterless <NA>  7924380  
     6     864800          19 Nilaqua Hand Sanitiser 500ml Waterless <NA>  7924372  
     7     864812          19 EcoHydra Alcohol Free Antib… Ecohydra  <NA>  6291562  
     8     864815          19 EcoHydra Alcohol Free Antib… Ecohydra  <NA>  1559087  
     9     882456          33 Stuf Hand Sanitiser 50ml Tu… Stuf      <NA>  <NA>     
    10     845565          30 Dr. Bronner's Organic Hand … Dr Bronn… <NA>  362030011
    # … with 99 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 179 x 6
       product_id retailer_id product                    brand  model    sku        
            <int>       <int> <chr>                      <chr>  <chr>    <chr>      
     1    1141614          35 NESPRESSO Magimix Vertuo … NESPR… <NA>     311-820409…
     2     747269          10 Nespresso CitiZ & Milk Co… NESPR… C123-ZA… 0000000000…
     3     904762          10 Nescafe Coffee Alta Rica … NESCA… <NA>     0000000003…
     4     904763          10 Nescafe Coffee Gold Mild … NESCA… <NA>     0000000003…
     5    1381129          10 Nescafe Dolce Gusto Coffe… NESCA… <NA>     0000000002…
     6    1223437          10 Nescafe Coffee Espresso (… NESCA… <NA>     0000000003…
     7    1224156          10 Nescafe Esperta Capsule C… NESCA… 12397948 0000000000…
     8    1177845          35 NESPRESSO Magimix CitiZ &… NESPR… <NA>     311-820409…
     9    1177846          35 NESPRESSO Magimix CitiZ c… NESPR… <NA>     311-820409…
    10    1177848          35 NESPRESSO Magimix CitiZ c… NESPR… <NA>     311-820409…
    # … with 169 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 947 x 6
       product_id retailer_id product                          brand  model  sku    
            <int>       <int> <chr>                            <chr>  <chr>  <chr>  
     1     751014          46 "Samsung 43 Inch UHD 4K Flat Sm… Samsu… <NA>   UA43RU…
     2     750911          46 "Samsung 40 Inch FHD Flat TV UA… Samsu… <NA>   UA40N5…
     3     770948           4 "Hisense 58\" Android UHD TV"    HISEN… 58B72… 008009…
     4     750953          46 "Samsung 65 Inch UHD 4K Flat Sm… Samsu… <NA>   UA65RU…
     5     753374          47 "Samsung 190cm(75\") Q900R QLED… Samsu… <NA>   69173WD
     6     753361          47 "Samsung 190cm(75\") Q900R QLED… Samsu… <NA>   69173WD
     7     753363          47 "Samsung 208cm(82\") QLED Smart… Samsu… <NA>   67637WD
     8     753369          47 "Samsung 190cm(75\") Q900R QLED… Samsu… <NA>   69173WD
     9     753372          47 "Samsung 165cm (65\") Q900R QLE… Samsu… <NA>   67631  
    10     753373          47 "Samsung 208cm(82\") QLED Smart… Samsu… <NA>   67637WD
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

    # A tibble: 34 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-05-02 04:27:22  50.0            40.0            40.0
     2     530290 2020-05-01 02:20:50  50.0            40.0            40.0
     3     530290 2020-04-30 02:21:07  50.0            40.0            40.0
     4     530290 2020-04-29 02:21:04  50.0            40.0            40.0
     5     530290 2020-04-28 02:50:09  50.0            40.0            40.0
     6     530290 2020-04-27 01:55:26  50.0            40.0            40.0
     7     530290 2020-04-26 01:59:51  50.0            40.0            40.0
     8     530290 2020-04-25 02:00:59  50.0            40.0            40.0
     9     530290 2020-04-24 01:32:45  50.0            40.0            40.0
    10     530290 2020-04-23 02:09:10  50.0            40.0            40.0
    # … with 24 more rows, and 1 more variable: available <lgl>
