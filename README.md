
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
       product_id product                                  brand   model sku        
            <int> <chr>                                    <chr>   <chr> <chr>      
     1    3386147 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     2    3386148 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     3    3386149 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     4    3386150 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     5    3386151 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     6    3386152 Moon Stripe Fleece Hoodies 2 Pack - X G… <NA>    <NA>  6009214873…
     7    3316131 Black Push Up Jeggings - BLACK / 20      RE:     <NA>  6009217179…
     8    3316118 Tie Neck Blouse Blouse - LIME / 16       Edition <NA>  6009217225…
     9    3316119 Tie Neck Blouse Blouse - LIME / 10       Edition <NA>  6009217225…
    10    3316120 Tie Neck Blouse Blouse - LIME / 20       Edition <NA>  6009217225…
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
     1     667365 NESPRESSO Essenza Mini Coffee Machine  Nespres… <NA>  76300396187…
     2     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespres… <NA>  76300544309…
     3     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespres… <NA>  76300476151…
     4     667815 NESPRESSO Lattissima One Coffee Machi… Nespres… <NA>  76300396464…
     5     729093 NESPRESSO Creatista Plus Coffee Machi… Nespres… <NA>  76300396488…
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
       product_id retailer_id product                    brand      model sku       
            <int>       <int> <chr>                      <chr>      <chr> <chr>     
     1    3398418           2 Hand Sanitiser Total 10 1… Lifebuoy   <NA>  337506    
     2     535758           9 Dettol Floral Hand Saniti… <NA>       <NA>  000000000…
     3     535759           9 Dettol Floral Hand Saniti… <NA>       <NA>  000000000…
     4     535782           9 Dettol Hand Sanitiser 50ml <NA>       <NA>  000000000…
     5     535783           9 Dettol Hand Sanitiser 200… <NA>       <NA>  000000000…
     6    3400372           2 Hand Sanitiser Original C… Dettol     <NA>  338710    
     7    3400839           2 Waterless Hand Sanitiser … Clicks Ex… <NA>  336320    
     8    3400847           2 Hand Sanitiser 200ml       Clere      <NA>  337181    
     9    3403148          19 Vichy Hand Sanitiser Gel … Vichy      <NA>  1104268   
    10    3482998          42 Character Hand Sanitiser … MRP Girls… <NA>  472101009…
    # … with 286 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    Retrieving 302 results (1 pages).

    Retrieved 302 results.

    Received fewer rows than requested.

    # A tibble: 302 x 6
       product_id retailer_id product                    brand      model sku       
            <int>       <int> <chr>                      <chr>      <chr> <chr>     
     1    3395848          10 Nescafe Ricoffy Coffee (1… NESCAFE    <NA>  000000000…
     2    3394146          10 Nescafe Ricoffy Coffee (1… NESCAFE    <NA>  000000000…
     3    3430293          16 Nespresso by Krups Citiz … Nespresso  <NA>  8909914   
     4    3422813          16 Nescafe Dolce Gusto Krups… Nescafe D… <NA>  9344004   
     5    3433349          16 Nespresso by Magimix Citi… Nespresso  <NA>  8809344   
     6    3430600          16 Nespresso by Magimix Esse… Nespresso  <NA>  8898441   
     7    3430630          16 Nespresso by Magimix Citi… Nespresso  <NA>  8897789   
     8    3430957          16 Nespresso by Krups Citiz … Nespresso  <NA>  8890638   
     9    3435877          16 Nescafe Dolce Gusto Krups… Nescafe D… <NA>  8642848   
    10    3433794          16 Nescafe Dolce Gusto by Kr… Nescafe D… <NA>  8800350   
    # … with 292 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    Retrieving 1703 results (1 pages).

    Retrieved 1703 results.

    Received fewer rows than requested.

    # A tibble: 1,703 x 6
       product_id retailer_id product                         brand  model sku      
            <int>       <int> <chr>                           <chr>  <chr> <chr>    
     1    3523877          66 Hisense 55AE7010F LED-Fernsehe… Hisen… <NA>  70811257…
     2     525111           4 55 QLED TV                      SAMSU… 55Q6… 00800380 
     3     526360          12 Samsung 40inch FHD Smart TV Se… SAMSU… <NA>  00000000…
     4    3525374          66 Samsung GQ85Q95T QLED-Fernsehe… Samsu… <NA>  36558354…
     5    3533875          66 Samsung GU55TU8509 LED-Fernseh… Samsu… <NA>  43409142…
     6    3529519          66 Hisense H43BE7200 LED-Fernsehe… Hisen… <NA>  61280428…
     7    3421443          16 Samsung 65 Inch UE65RU7300KXXU… Samsu… <NA>  9420636  
     8    3421477          16 Samsung 55 Inch UE55RU7100KXXU… Samsu… <NA>  9417539  
     9    3421594          16 Hisense 50 Inch H50B7500UK Sma… Hisen… <NA>  9406038  
    10    3421648          16 Samsung 65 Inch UE65RU7400UXXU… Samsu… <NA>  9403402  
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

### Documentation

Once you’ve bumped the version, rebuild the documentation.

1.  Knit `README.Rmd`.
2.  Run `pkgdown::build_site()`.
