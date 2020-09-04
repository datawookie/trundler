
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

    [1] '0.1.20'

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

    Retrieving 202282 results (21 pages).

    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.
    Retrieved 10000 results.

    Retrieved 2282 results.

    Received fewer rows than requested.

    # A tibble: 202,282 x 5
       product_id product                                 brand      model sku      
            <int> <chr>                                   <chr>      <chr> <chr>    
     1    2874080 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
     2    2839652 Glam Jasmine EDP - 30ml                 Michael K… <NA>  22548289…
     3    2839712 Cool Water EDT - 30ml                   Davidoff   <NA>  34142020…
     4    2874081 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
     5    2839713 Women Original EDP - 30ml               DKNY       <NA>  76351109…
     6    2874082 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
     7    2874083 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
     8    2874084 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
     9    2839714 Women Original EDP - 50ml               DKNY       <NA>  76351110…
    10    2874085 Lace Total Support DD+ Non-wire Bras 2… <NA>       <NA>  60091957…
    # … with 202,272 more rows

Products can be filtered by name and brand.

``` r
retailer_products(5, product = "coffee", brand = "nespresso")
```

    Retrieving 10 results (1 pages).

    Retrieved 10 results.

    Received fewer rows than requested.

    # A tibble: 10 x 5
       product_id product                                brand    model sku         
            <int> <chr>                                  <chr>    <chr> <chr>       
     1     729093 NESPRESSO Creatista Plus Coffee Machi… Nespres… <NA>  76300396488…
     2     667365 NESPRESSO Essenza Mini Coffee Machine  Nespres… <NA>  76300396187…
     3     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespres… <NA>  76300544309…
     4     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespres… <NA>  76300476151…
     5     667815 NESPRESSO Lattissima One Coffee Machi… Nespres… <NA>  76300396464…
     6    2918572 Creatista Plus Coffee Machine - SILVER Nespres… <NA>  76300396488…
     7    2918582 Citiz&Milk Coffee Machine - WHITE      Nespres… <NA>  76300544309…
     8    2918584 Lattissima One Coffee Machine - WHITE  Nespres… <NA>  76300396464…
     9    2918599 Essenza Mini Coffee Machine - BLACK    Nespres… <NA>  76300396187…
    10    2918601 Lattissima Touch Coffee Machine - SIL… Nespres… <NA>  76300476151…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    Retrieving 296 results (1 pages).

    Retrieved 296 results.

    Received fewer rows than requested.

    # A tibble: 296 x 6
       product_id retailer_id product                    brand     model sku        
            <int>       <int> <chr>                      <chr>     <chr> <chr>      
     1    3327051          32 Lifetrek Hand Sanitiser G… <NA>      <NA>  1031192    
     2    3327215          32 Lifetrek Hand Sanitiser G… <NA>      <NA>  1031192    
     3    3353772           3 Dettol Hand Sanitiser 500… <NA>      <NA>  288075     
     4    3342615          19 Pack of 10 PHR Hand Sanit… <NA>      <NA>  8983720    
     5    3352829          19 La Roche-Posay Hydroalcoh… La Roche… <NA>  8940843    
     6    3352887          19 Opal Plus Hand Sanitiser … Boots     <NA>  8927928    
     7    3352888          19 Dr Palm Hand Sanitiser Bo… Dr Palm   <NA>  8913560    
     8    3352890          19 Dr Palm Hand Sanitiser Tu… Dr Palm   <NA>  8913552    
     9    3345113          18 Autoglym Hand Sanitiser 1… Autoglym  <NA>  436046     
    10     284382          10 DETTOL Hand Sanitiser Ori… DETTOL    <NA>  0000000001…
    # … with 286 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    Retrieving 302 results (1 pages).

    Retrieved 302 results.

    Received fewer rows than requested.

    # A tibble: 302 x 6
       product_id retailer_id product                           brand  model sku    
            <int>       <int> <chr>                             <chr>  <chr> <chr>  
     1       2383          30 Nescafe Gold Blend Instant Coffee Nesca… <NA>  380351…
     2       2183          30 Nescafe Azera Americano Instant … Nesca… <NA>  113759…
     3       2231          30 Nescafe Gold Cappuccino Decaf Co… Nesca… <NA>  367529…
     4       2236          30 Nescafe Gold Cappuccino Coffee 8… Nesca… <NA>  367527…
     5       2241          30 Nescafe Azera Latte 6 Coffees     Nesca… <NA>  439367…
     6       2323          30 Nescafe Original Instant Coffee   Nesca… <NA>  212223…
     7       2324          30 Nescafe Original Instant Coffee   Nesca… <NA>  113815…
     8       2476          30 Nescafe Dolce Gusto Cafe Au Lait… Nesca… <NA>  290509…
     9       2515          30 Nescafe Original Decaff Instant … Nesca… <NA>  268419…
    10       2524          30 Nescafe Original Decaff Instant … Nesca… <NA>  113819…
    # … with 292 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    Retrieving 1703 results (1 pages).

    Retrieved 1703 results.

    Received fewer rows than requested.

    # A tibble: 1,703 x 6
       product_id retailer_id product                     brand  model    sku       
            <int>       <int> <chr>                       <chr>  <chr>    <chr>     
     1    3340772          10 "Samsung 138 cm (55\") Sma… SAMSU… UA55RU7… 000000000…
     2    3333903          51 "Samsung LED 40 inch Smart… Samsu… <NA>     UA40N5300 
     3    3334031          10 "Samsung 179 cm (70\") Sma… SAMSU… 70RU710… 000000000…
     4    3334047          10 "Samsung 138 cm (55\") Sma… SAMSU… UA55RU7… 000000000…
     5    3336009          51 "Samsung 32” UA32N5003 LED… Samsu… <NA>     UA32N5003 
     6    3337268          10 "Samsung 179 cm (70\") Sma… SAMSU… 70RU710… 000000000…
     7    3368372          47 "Hisense 254cm(100\")Laser… Hisen… <NA>     69951     
     8    3366005          47 "Samsung 190cm (75\") UHD … Samsu… <NA>     67645SAM  
     9       1882           4 "49\" SMART LED TV"         SAMSU… 49N5300  00788153  
    10    3369106          47 "Samsung 190cm (75\") UHD … Samsu… <NA>     67645SAM  
    # … with 1,693 more rows

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

    Retrieving 100 results (1 pages).

    Retrieved 100 results.

    Received fewer rows than requested.

    # A tibble: 100 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-09-04 04:10:46  50.0            NA              50.0
     2     530290 2020-09-02 03:57:02  50.0            NA              50.0
     3     530290 2020-08-28 03:52:34  50.0            NA              50.0
     4     530290 2020-08-26 04:29:28  50.0            NA              50.0
     5     530290 2020-08-24 04:49:35  50.0            NA              50.0
     6     530290 2020-08-21 04:57:07  50.0            40.0            40.0
     7     530290 2020-08-19 01:22:35  50.0            40.0            40.0
     8     530290 2020-08-17 04:49:36  50.0            40.0            40.0
     9     530290 2020-08-14 04:09:58  50.0            40.0            40.0
    10     530290 2020-08-12 04:07:12  50.0            40.0            40.0
    # … with 90 more rows, and 1 more variable: available <lgl>

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

## Package Maintenance

### Managing Version

Use [bump2version](https://pypi.org/project/bump2version/) to cleanly
increment the version.

``` bash
$ bump2version patch
$ bump2version minor
$ bump2version major
```
