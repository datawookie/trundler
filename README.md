
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

    [1] '0.1.19'

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

    # A tibble: 140 x 5
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
    # … with 130 more rows

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

    Retrieving 195201 results (20 pages).

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

    Retrieved 5201 results.

    Received fewer rows than requested.

    # A tibble: 195,201 x 5
       product_id product                              brand       model sku        
            <int> <chr>                                <chr>       <chr> <chr>      
     1    3335833 Chino Short - NAVY / 8               Country Ro… <NA>  9327735033…
     2    3335978 Plain Cotton Rich Trunks 3 Pack - R… <NA>        <NA>  6009214350…
     3    3336524 TRENERY Lilith Leather Slide - BLAC… Trenery     <NA>  9327735780…
     4    3336634 Linen Cami - SAGE / 16               Country Ro… <NA>  9338358694…
     5    3336685 Crepe Swing Tank - ANTIQUE WHITE / M Country Ro… <NA>  9340243960…
     6    3336802 Krystal Canvas Sneaker - NAVY / 41   Country Ro… <NA>  9340243965…
     7    3336846 Fluffy Acrylic Jumper - X GREY / L   Edition     <NA>  6009217246…
     8    3337033 Britney Suede Boot - BLACK / 36      Witchery    <NA>  9354530249…
     9    3337402 Cleo Leather Gloves - BLACK / SM     Witchery    <NA>  9354530269…
    10    3337645 High Waist Straight Jean - ECRU / 6  Country Ro… <NA>  9338358581…
    # … with 195,191 more rows

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

    Retrieving 260 results (1 pages).

    Retrieved 260 results.

    Received fewer rows than requested.

    # A tibble: 260 x 6
       product_id retailer_id product                       brand      model sku    
            <int>       <int> <chr>                         <chr>      <chr> <chr>  
     1    3603789          42 Character Hand Sanitiser - P… MRP Boys … <NA>  472101…
     2    4105371         105 Foundation Hand Sanitiser 60… Cotton On… <NA>  963015…
     3    3867434           4 Dettol Hand Sanitiser ORIGIN… Dettol     <NA>  814047…
     4    3850285          19 Boots Face Mask, Nemesis Han… <NA>       <NA>  1157965
     5    3684041          42 Hand Sanitiser 100ml          MRP Cosme… <NA>  01_172…
     6    3867372           4 Dettol Hand Sanitiser FLORAL… Dettol     <NA>  814047…
     7    3843651          19 Boots Face Mask, Nemesis Han… <NA>       <NA>  1157973
     8    3950153          42 Hand Sanitiser 60ml - Orange… MRP Cosme… <NA>  172511…
     9    3950155          42 Hand Sanitiser 60ml - Sunshi… MRP Cosme… <NA>  172511…
    10    3950156          42 Hand Sanitiser 60ml - Baby B… MRP Cosme… <NA>  172511…
    # … with 250 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    Retrieving 295 results (1 pages).

    Retrieved 295 results.

    Received fewer rows than requested.

    # A tibble: 295 x 6
       product_id retailer_id product                      brand     model sku      
            <int>       <int> <chr>                        <chr>     <chr> <chr>    
     1    3655016          16 Nescafe Dolce Gusto De'Long… Nescafe … <NA>  2391157  
     2    3654881          16 Nescafe Dolce Gusto by Krup… Nescafe … <NA>  2415057  
     3    3740883          10 Nescafe Gold Cappuccino Cof… NESCAFE … <NA>  00000000…
     4    3740885          10 Nescafe Gold Cappuccino Cof… NESCAFE … <NA>  00000000…
     5    4091684          47 Nespresso Essenza Mini bund… Nespresso <NA>  61399NES 
     6    4091413          47 Nespresso Gran Lattissima C… Nespresso <NA>  72485NES 
     7    4091414          47 Nespresso Essenza Mini C30 … Nespresso <NA>  61394NES 
     8    4091417          47 Nespresso Essenza Mini C30 … Nespresso <NA>  61395NES 
     9    4091679          47 Nespresso Red Essenza Mini … Nespresso <NA>  61397NES 
    10    4091681          47 Nespresso Creatista Plus - … Nespresso <NA>  63290NES 
    # … with 285 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    Retrieving 1606 results (1 pages).

    Retrieved 1606 results.

    Received fewer rows than requested.

    # A tibble: 1,606 x 6
       product_id retailer_id product                            brand  model sku   
            <int>       <int> <chr>                              <chr>  <chr> <chr> 
     1    3637494          16 "Samsung 43 Inch UE43RU7410UXXU S… Samsu… <NA>  29993…
     2    3604265          66 "Hisense H50U7B LED-Fernseher (12… Hisen… <NA>  46153…
     3    3607697          16 "Samsung 50 Inch UE50RU7410UXXU S… Samsu… <NA>  32873…
     4    3615344          66 "Hisense 55AE7200F LED-Fernseher … Hisen… <NA>  98510…
     5    3616796          16 "Samsung 43 Inch The Frame QE43LS… Samsu… <NA>  31900…
     6    3624147          16 "Samsung 43 Inch UE43RU7020 Smart… Samsu… <NA>  31224…
     7    3633579          66 "Samsung GQ65Q950T QLED-Fernseher… Samsu… <NA>  76364…
     8    3633839          16 "Samsung 65 Inch UE65RU7020 Smart… Samsu… <NA>  30610…
     9    3639072          66 "Hisense H65BE7000 LED-Fernseher … Hisen… <NA>  29622…
    10    3644844          47 "Samsung 208cm(82\") PUHD Smart T… Samsu… <NA>  69545…
    # … with 1,596 more rows

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

    Retrieving 94 results (1 pages).

    Retrieved 94 results.

    Received fewer rows than requested.

    # A tibble: 94 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-08-19 01:22:35  50.0            40.0            40.0
     2     530290 2020-08-17 04:49:36  50.0            40.0            40.0
     3     530290 2020-08-14 04:09:58  50.0            40.0            40.0
     4     530290 2020-08-12 04:07:12  50.0            40.0            40.0
     5     530290 2020-08-10 04:00:57  50.0            NA              50.0
     6     530290 2020-08-07 03:54:26  50.0            NA              50.0
     7     530290 2020-08-05 03:39:28  50.0            NA              50.0
     8     530290 2020-08-03 04:07:52  50.0            NA              50.0
     9     530290 2020-07-31 03:53:20  50.0            NA              50.0
    10     530290 2020-07-29 03:02:07  50.0            NA              50.0
    # … with 84 more rows, and 1 more variable: available <lgl>

### Options

You can control the volume of console output with options:

  - `options(trundler.chatty = TRUE)`: provide more output; and
  - `options(trundler.chatty = FALSE)`: provide less output.

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
