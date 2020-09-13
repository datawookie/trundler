
<!-- README.md is generated from README.Rmd. Please edit that file -->

# trundler <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/trundler.svg?branch=master)](https://travis-ci.org/datawookie/trundler)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/trundler.svg)](https://codecov.io/github/datawookie/trundler)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

[Trundler](https://www.trundler.dev) provides access to product and
historical price data from a range of online retailers.

The homepage for the {trundler} R package is at
<https://datawookie.github.io/trundler/>.

## Installation

Install from GitHub.

``` r
remotes::install_github("datawookie/trundler")
```

If you want to be closer to the bleeding edge then you can also install
from the development branch.

``` r
remotes::install_github("datawookie/trundler", ref = "dev")
```

## Usage

``` r
library(trundler)
```

Check version.

``` r
packageVersion("trundler")
```

    [1] '0.1.21'

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

    # A tibble: 143 x 5
       retailer_id retailer         retailer_url                    currency visible
             <int> <chr>            <chr>                           <chr>    <lgl>  
     1           1 EEM Technologies https://www.eemtechnologies.co… USD      TRUE   
     2           2 Clicks           https://clicks.co.za/           ZAR      TRUE   
     3           3 Dischem          https://www.dischem.co.za/      ZAR      TRUE   
     4           4 Game             https://www.game.co.za/         ZAR      TRUE   
     5           5 Woolworths       https://www.woolworths.co.za/   ZAR      TRUE   
     6           6 Fortnum & Mason  https://www.fortnumandmason.co… GBP      FALSE  
     7           7 John Lewis       https://www.johnlewis.com/      GBP      FALSE  
     8           8 Marks & Spencer  https://www.marksandspencer.co… GBP      FALSE  
     9           9 Pick 'n Pay      https://www.pnp.co.za/          ZAR      TRUE   
    10          10 Makro            https://www.makro.co.za/        ZAR      TRUE   
    # … with 133 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(45)
```

``` 
# A tibble: 1 x 5
  retailer_id retailer           retailer_url                currency visible
        <int> <chr>              <chr>                       <chr>    <lgl>  
1          45 Builders Warehouse https://www.builders.co.za/ ZAR      TRUE   
```

### Products

Get a list of products for a specific retailer.

``` r
retailer_products(5)
```

    # A tibble: 206,865 x 5
       product_id product                             brand        model sku        
            <int> <chr>                               <chr>        <chr> <chr>      
     1    1038294 CHARLOTTE RHYS St Thomas Shower Gel Charlotte R… <NA>  6061102572…
     2    1038316 LONGMARKET Bath & Body Gift Box     W Bath&Body  <NA>  6009214571…
     3    1038325 SIMPLY FLORAL Travel Set            W Bath&Body  <NA>  6009214797…
     4    1038356 CHARLOTTE RHYS Spring Flowers Liqu… Charlotte R… <NA>  6061102561…
     5    1038370 SIMPLY FLORAL Body Soufflé          W Bath&Body  <NA>  6009214170…
     6    1038395 Fresh Lemon Zest Hand Wash & Lotio… W Bath&Body  <NA>  6009214464…
     7    1038409 TOM FORD Oud Wood Shower Gel        Tom Ford     <NA>  8880660240…
     8    1038428 SIMPLY FLORAL Mini Hand & Nail Cre… W Bath&Body  <NA>  6009214169…
     9    1038458 EXTRACTS FROM NATURE Hand Wash      W Bath&Body  <NA>  6009207048…
    10    1038469 EVERYDAY Body Butter                W Bath&Body  <NA>  6009101665…
    # … with 206,855 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, product = "coffee", brand = "nespresso")
```

    # A tibble: 10 x 5
       product_id product                                brand    model sku         
            <int> <chr>                                  <chr>    <chr> <chr>       
     1    2918572 Creatista Plus Coffee Machine - SILVER Nespres… <NA>  76300396488…
     2    2918582 Citiz&Milk Coffee Machine - WHITE      Nespres… <NA>  76300544309…
     3    2918584 Lattissima One Coffee Machine - WHITE  Nespres… <NA>  76300396464…
     4    2918599 Essenza Mini Coffee Machine - BLACK    Nespres… <NA>  76300396187…
     5    2918601 Lattissima Touch Coffee Machine - SIL… Nespres… <NA>  76300476151…
     6     667815 NESPRESSO Lattissima One Coffee Machi… Nespres… <NA>  76300396464…
     7     667365 NESPRESSO Essenza Mini Coffee Machine  Nespres… <NA>  76300396187…
     8     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespres… <NA>  76300544309…
     9     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespres… <NA>  76300476151…
    10     729093 NESPRESSO Creatista Plus Coffee Machi… Nespres… <NA>  76300396488…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    # A tibble: 297 x 6
       product_id retailer_id product                     brand     model sku       
            <int>       <int> <chr>                       <chr>     <chr> <chr>     
     1    1427238           5 CHARLOTTE RHYS St Thomas W… Charlott… <NA>  606110261…
     2    1782675           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     3    1753347          63 Waterless Hand Sanitiser -… Charlott… <NA>  FCR075HAN…
     4    1753348          63 Waterless Hand Sanitiser -… Charlott… <NA>  FCR300WHS 
     5    1782558           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     6    1782566           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     7    1782684           3 Aquashield Hand Sanitiser … <NA>      <NA>  000000000…
     8    1403656           5 BATH TIME Hand Sanitiser    W Bath&B… <NA>  600921127…
     9    1322118           2 Total 10 Hand Sanitiser 50… Lifebuoy  <NA>  309637    
    10    1202656          33 Stuf Hand Sanitiser 50ml T… Stuf      <NA>  <NA>      
    # … with 287 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 308 x 6
       product_id retailer_id product                      brand    model sku       
            <int>       <int> <chr>                        <chr>    <chr> <chr>     
     1    1492620          13 Nescafe Original Decaffeina… NESCAFE  <NA>  254889371 
     2    1471626          35 NESPRESSO Magimix CitiZ & M… NESPRES… <NA>  311-82040…
     3    1492559          13 Nescafe Gold Blend Decaffei… NESCAFE  <NA>  297334444 
     4    1492561          13 Nescafe Original Instant Co… NESCAFE  <NA>  254889618 
     5    1492562          13 Nescafe Azera Americano Ins… NESCAFE… <NA>  273581584 
     6    1492579          13 Nescafe Azera Americano Cof… NESCAFE  <NA>  304366804 
     7    1492566          13 Nescafe Gold Blend Coffee 2… NESCAFE  <NA>  297876977 
     8    1492573          13 Nescafe Azera Americano Ins… NESCAFE  <NA>  276731645 
     9    1492577          13 Nescafe Azera Intenso Insta… NESCAFE  <NA>  276731680 
    10    1492576          13 Nescafe Azera Americano Dec… NESCAFE  <NA>  296836819 
    # … with 298 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 1,759 x 6
       product_id retailer_id product                          brand  model sku     
            <int>       <int> <chr>                            <chr>  <chr> <chr>   
     1    1417371          51 "Samsung LED 49\" Curved UHD Sm… Samsu… <NA>  UA49RU7…
     2    1417643          51 "Samsung Ua32n5300 LED TV 32 in… Samsu… <NA>  UA32N53…
     3    1417684          51 "Samsung 55\" UA55RU7100 LED UH… Samsu… <NA>  UA55RU7…
     4    1417685          51 "Samsung 43\" UA43RU7100 LED UH… Samsu… <NA>  UA43RU7…
     5    1417686          51 "Samsung 49\" UA49N5300 LED FHD… Samsu… <NA>  UA49N53…
     6    1417977          51 "Samsung 49\" UA49RU7100 LED UH… Samsu… <NA>  UA49RU7…
     7    1417983          51 "Samsung 55\" QA55Q60RAK QLED 4… Samsu… <NA>  QA55Q60…
     8    1417984          51 "Samsung 65” QA65Q60RAK QLED UH… Samsu… <NA>  QA65Q60…
     9    1417987          51 "Samsung 65” QA65Q900RBK QLED 8… Samsu… <NA>  QA65Q90…
    10    1417988          51 "Samsung 65\" QA65Q70RAK QLED U… Samsu… <NA>  QA65Q70…
    # … with 1,749 more rows

Information on a specific product.

``` r
item <- product(530290)
```

What fields are available?

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

    [[1]]
    [1] "6001087378543"

### Prices

Get price history data for a specific product.

``` r
product_prices(530290)
```

    # A tibble: 103 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-09-11 03:43:14  50.0            NA              50.0
     2     530290 2020-09-09 03:42:51  50.0            NA              50.0
     3     530290 2020-09-07 04:17:00  50.0            NA              50.0
     4     530290 2020-09-04 04:10:46  50.0            NA              50.0
     5     530290 2020-09-02 03:57:02  50.0            NA              50.0
     6     530290 2020-08-28 03:52:34  50.0            NA              50.0
     7     530290 2020-08-26 04:29:28  50.0            NA              50.0
     8     530290 2020-08-24 04:49:35  50.0            NA              50.0
     9     530290 2020-08-21 04:57:07  50.0            40.0            40.0
    10     530290 2020-08-19 01:22:35  50.0            40.0            40.0
    # … with 93 more rows, and 1 more variable: available <lgl>

### Options

You can control the volume of console output with options:

  - `options(trundler.chatty = TRUE)`: provide more output; and
  - `options(trundler.chatty = FALSE)`: provide less output.

## RMarkdown Template

You can use the Trundler RMarkdown template to quickly produce
visualisations for product price histories. After installing the
package, select “Trundler Report Template” under the “From Template”
option on the **New RMarkdown** dialog.

*Note:* You might need to restart RStudio before the template shows up
in the menu.
