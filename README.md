
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

    # A tibble: 203,577 x 5
       product_id product                            brand        model sku         
            <int> <chr>                              <chr>        <chr> <chr>       
     1    2897993 Quilted Sweat Skirt - PALE PINK /… Country Road <NA>  93545301350…
     2    2897908 Puffer Jacket - CHARCOAL / 10-11   Country Road <NA>  93545301915…
     3    2897909 Puffer Jacket - CHARCOAL / 8-9     Country Road <NA>  93545301915…
     4    2897910 Puffer Jacket - CHARCOAL / 6-7     Country Road <NA>  93545301916…
     5    2897911 Puffer Jacket - CHARCOAL / 4-5     Country Road <NA>  93545301916…
     6    2897912 Puffer Jacket - CHARCOAL / 2-3     Country Road <NA>  93545301915…
     7    2897919 Mini Floral Skort - WHITE / 5      Country Road <NA>  93383588690…
     8    2897920 Mini Floral Skort - WHITE / 10     Country Road <NA>  93383588691…
     9    2897921 Mini Floral Skort - WHITE / 7      Country Road <NA>  93383588690…
    10    2897922 Mini Floral Skort - WHITE / 8      Country Road <NA>  93383588690…
    # … with 203,567 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, product = "coffee", brand = "nespresso")
```

    # A tibble: 10 x 5
       product_id product                                brand    model sku         
            <int> <chr>                                  <chr>    <chr> <chr>       
     1     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespres… <NA>  76300476151…
     2     729093 NESPRESSO Creatista Plus Coffee Machi… Nespres… <NA>  76300396488…
     3    2918572 Creatista Plus Coffee Machine - SILVER Nespres… <NA>  76300396488…
     4    2918582 Citiz&Milk Coffee Machine - WHITE      Nespres… <NA>  76300544309…
     5    2918584 Lattissima One Coffee Machine - WHITE  Nespres… <NA>  76300396464…
     6    2918599 Essenza Mini Coffee Machine - BLACK    Nespres… <NA>  76300396187…
     7    2918601 Lattissima Touch Coffee Machine - SIL… Nespres… <NA>  76300476151…
     8     667365 NESPRESSO Essenza Mini Coffee Machine  Nespres… <NA>  76300396187…
     9     667815 NESPRESSO Lattissima One Coffee Machi… Nespres… <NA>  76300396464…
    10     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespres… <NA>  76300544309…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    # A tibble: 297 x 6
       product_id retailer_id product                  brand        model sku       
            <int>       <int> <chr>                    <chr>        <chr> <chr>     
     1     704378           5 FRESH DELIGHTS Hand San… W Bath&Body  <NA>  600921122…
     2     707065           3 Nature's Nourishment Ha… Nature's No… <NA>  000000000…
     3     734941          33 Stuf Hand Sanitiser 50m… Stuf         <NA>  <NA>      
     4     763695           3 Dettol Hand Sanitiser 2… Dettol       <NA>  000000000…
     5     806750           5 FRESH DELIGHTS Hand San… W Bath&Body  <NA>  600921122…
     6    1282330           3 Nature's Nourishment Ha… Nature's No… <NA>  000000000…
     7     820722          33 Stuf Hand Sanitiser 50m… Stuf         <NA>  <NA>      
     8     845565          30 Dr. Bronner's Organic H… Dr Bronner   <NA>  362030011 
     9     864780          19 Nilaqua Alcohol Free Ha… Waterless    <NA>  7924380   
    10     864800          19 Nilaqua Hand Sanitiser … Waterless    <NA>  7924372   
    # … with 287 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 307 x 6
       product_id retailer_id product                    brand   model    sku       
            <int>       <int> <chr>                      <chr>   <chr>    <chr>     
     1     729093           5 NESPRESSO Creatista Plus … Nespre… <NA>     763003964…
     2    1141614          35 NESPRESSO Magimix Vertuo … NESPRE… <NA>     311-82040…
     3     904762          10 Nescafe Coffee Alta Rica … NESCAFE <NA>     000000000…
     4     904763          10 Nescafe Coffee Gold Mild … NESCAFE <NA>     000000000…
     5    1177845          35 NESPRESSO Magimix CitiZ &… NESPRE… <NA>     311-82040…
     6    1177846          35 NESPRESSO Magimix CitiZ c… NESPRE… <NA>     311-82040…
     7    1177848          35 NESPRESSO Magimix CitiZ c… NESPRE… <NA>     311-82040…
     8     747269          10 Nespresso CitiZ & Milk Co… NESPRE… C123-ZA… 000000000…
     9    1223327          10 Nescafe Dolce Gusto Coffe… NESCAFE <NA>     000000000…
    10    1223437          10 Nescafe Coffee Espresso (… NESCAFE <NA>     000000000…
    # … with 297 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 1,731 x 6
       product_id retailer_id product                        brand   model   sku    
            <int>       <int> <chr>                          <chr>   <chr>   <chr>  
     1     701860          31 "HISENSE - 65\" ULED TV"       HISENSE 65B8000 008027…
     2     701877          31 "HISENSE - Hisense 50\" UHD S… HISENSE 50B710… 008009…
     3     702121          31 "SAMSUNG - 65 8K QLED TV"      SAMSUNG 65Q900R 008009…
     4     702120          31 "SAMSUNG - 55 QLED TV"         SAMSUNG 55Q60R  008003…
     5     701864          31 "HISENSE - 65\" UHD Smart TV"  HISENSE 65B710… 008031…
     6     701865          31 "SAMSUNG - 55 Smart UHD TV"    SAMSUNG 55RU71… 007986…
     7     701866          31 "SAMSUNG - 32\" SMART HD TV"   SAMSUNG 32N5300 007858…
     8     701875          31 "SAMSUNG - 43 UHD TV"          SAMSUNG 43RU71… 008003…
     9     701878          31 "SAMSUNG - 49\" SMART LED TV"  SAMSUNG 49N5300 007881…
    10     701880          31 "SAMSUNG - 40\" SMART LED TV"  SAMSUNG 40N5300 007844…
    # … with 1,721 more rows

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

    # A tibble: 101 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
<<<<<<< HEAD
     1     530290 2020-09-07 04:17:00  50.0            NA              50.0
     2     530290 2020-09-04 04:10:46  50.0            NA              50.0
     3     530290 2020-09-02 03:57:02  50.0            NA              50.0
     4     530290 2020-08-28 03:52:34  50.0            NA              50.0
     5     530290 2020-08-26 04:29:28  50.0            NA              50.0
     6     530290 2020-08-24 04:49:35  50.0            NA              50.0
     7     530290 2020-08-21 04:57:07  50.0            40.0            40.0
     8     530290 2020-08-19 01:22:35  50.0            40.0            40.0
     9     530290 2020-08-17 04:49:36  50.0            40.0            40.0
    10     530290 2020-08-14 04:09:58  50.0            40.0            40.0
    # … with 91 more rows, and 1 more variable: available <lgl>

### Options

You can control the volume of console output with options:

  - `options(trundler.chatty = TRUE)`: provide more output; and
  - `options(trundler.chatty = FALSE)`: provide less output.

## RMarkdown Template

You can use the Trundler RMarkdown template to quickly produce
visualisations for product price histories. After installing the
package, select “Trundler Report Template” under the “From Template”
option on the **New RMarkdown** dialog. *Note:* You might need to
restart RStudio before the template shows up in the menu.
=======
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

## Template

You can use the Trundler RMarkdown template to quickly produce visualisations for product price histories.  After installing the package, select "Trundler Report Template" from the **New RMarkdown** dialog.

## Package Maintenance

### Managing Version

Use [bumpversion](https://pypi.org/project/bumpversion/) to cleanly
increment the version.

``` bash
$ bumpversion patch
$ bumpversion minor
$ bumpversion major
```
>>>>>>> 4e1a84c... Added instructions for using report template
