
<!-- README.md is generated from README.Rmd. Please edit that file -->

# trundler <img src="man/figures/logo.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/trundler.svg?branch=master)](https://travis-ci.org/datawookie/trundler)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/trundler.svg)](https://codecov.io/github/datawookie/trundler)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/895c172dbabe4e148fec2ba169398d81)](https://www.codacy.com/manual/datawookie/trundler?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=datawookie/trundler&amp;utm_campaign=Badge_Grade)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)

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

    [1] '0.1.23'

### Set API Key

To access the full API you’ll need to first specify an API key.

``` r
# Example API key (this key will not work).
set_api_key("8f9f3c4e-5dd6-4bff-3a2c-592b45cf2437")
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

You can also subscribe via
[RapidAPI](https://rapidapi.com/datawookie/api/trundler).

``` r
# Example RapidAPI key (this key will not work).
set_api_key("5a1ae0ce24mshd483dae6ab7308dp129ef6jsn1f473053d6b0")
```

### Retailers

Use `retailer()` to get a list of retailers.

``` r
retailer()
```

    # A tibble: 148 x 5
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
    # … with 138 more rows

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

    # A tibble: 215,578 x 5
       product_id product                                 brand   model sku         
            <int> <chr>                                   <chr>   <chr> <chr>       
     1    2849767 Micro Textured Blazer - DEEP BLUE / 48  Trenery <NA>  93402439912…
     2    2849768 Micro Textured Blazer - DEEP BLUE / 36  Trenery <NA>  93402439912…
     3    2849769 Micro Textured Blazer - DEEP BLUE / 40  Trenery <NA>  93402439912…
     4    2849770 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
     5    2849771 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
     6    2849772 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
     7    2849773 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
     8    2849774 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
     9    2849775 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
    10    2849776 Puppytooth Check Blazer - MARINE BLUE … Trenery <NA>  93545301015…
    # … with 215,568 more rows

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
     6     667365 NESPRESSO Essenza Mini Coffee Machine  Nespres… <NA>  76300396187…
     7     667426 NESPRESSO Citiz&Milk Coffee Machine    Nespres… <NA>  76300544309…
     8     667654 NESPRESSO Lattissima Touch Coffee Mac… Nespres… <NA>  76300476151…
     9     729093 NESPRESSO Creatista Plus Coffee Machi… Nespres… <NA>  76300396488…
    10     667815 NESPRESSO Lattissima One Coffee Machi… Nespres… <NA>  76300396464…

A similar search can be applied across *all* retailers.

``` r
products(product = "hand sanitiser")
```

    # A tibble: 315 x 6
       product_id retailer_id product                    brand     model sku        
            <int>       <int> <chr>                      <chr>     <chr> <chr>      
     1    1337317          63 Hand Sanitiser Mist, 50ml  Cape Isl… <NA>  HSSD50     
     2    1337319          63 Hand Sanitiser Pump, 200ml Cape Isl… <NA>  HSSD200    
     3    1356101          30 Dr. Bronner's Organic Han… <NA>      <NA>  362030011  
     4    1357926          30 Organic Children Hand San… <NA>      <NA>  66685011   
     5    1386565           9 LIFEBUOY HAND SANITISER T… <NA>      <NA>  0000000000…
     6    1385527           9 LIFEBUOY HAND SANITISER L… <NA>      <NA>  0000000000…
     7    1385530           9 LIFEBUOY HAND SANITISER T… <NA>      <NA>  0000000000…
     8    1380393          45 Shield Handex Hand Saniti… Shield    <NA>  661382     
     9    1782558           3 Aquashield Hand Sanitiser… <NA>      <NA>  0000000000…
    10    1427238           5 CHARLOTTE RHYS St Thomas … Charlott… <NA>  6061102616…
    # … with 305 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 308 x 6
       product_id retailer_id product                    brand      model sku       
            <int>       <int> <chr>                      <chr>      <chr> <chr>     
     1    1381129          10 Nescafe Dolce Gusto Coffe… NESCAFE    <NA>  000000000…
     2    1492579          13 Nescafe Azera Americano C… NESCAFE    <NA>  304366804 
     3    1486078          13 Nescafe Azera Espresso Ro… NESCAFE    <NA>  304366827 
     4    1471626          35 NESPRESSO Magimix CitiZ &… NESPRESSO  <NA>  311-82040…
     5    1486022          13 Nescafe Dolce Gusto Flat … NESCAFE D… <NA>  301217330 
     6    1486010          13 Nescafe Dolce Gusto Ameri… NESCAFE D… <NA>  276686404 
     7    1486025          13 Nescafe Dolce Gusto Cafe … NESCAFE D… <NA>  282108148 
     8    1486050          13 Nescafe Original Instant … NESCAFE    <NA>  254889590 
     9    1486060          13 Nescafe Gold Blend Instan… NESCAFE    <NA>  297334369 
    10    1486041          13 Nescafe Cap Colombie Coff… NESCAFE    <NA>  297860949 
    # … with 298 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 1,845 x 6
       product_id retailer_id product                        brand  model sku       
            <int>       <int> <chr>                          <chr>  <chr> <chr>     
     1    1337871          12 "Samsung 49-inch(124cm) Smart… SAMSU… <NA>  000000000…
     2    1402235          47 "Samsung 49\" UHD TV - UA49RU… Samsu… <NA>  67652SUP  
     3    1402267          47 "Samsung 139cm(55\") UHD TV -… Samsu… <NA>  67650     
     4    1401154          47 "Hisense 81cm (32\") HD TV - … Hisen… <NA>  68559     
     5    1402240          47 "Samsung 147cm(58\") UHD 4K F… Samsu… <NA>  67648SUP  
     6    1402243          47 "Samsung 109cm(43\") UHD 4K F… Samsu… <NA>  67653     
     7    1402246          47 "Hisense 81cm (32\") HD TV - … Hisen… <NA>  68559     
     8    1462280          35 "Black Bezel for The Frame 65… SAMSU… <NA>  5196-1020…
     9    1417643          51 "Samsung Ua32n5300 LED TV 32 … Samsu… <NA>  UA32N5300 
    10    1417647          51 "Samsung 82” UA82RU8000 LED U… Samsu… <NA>  UA82RU8000
    # … with 1,835 more rows

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

    # A tibble: 112 x 6
       product_id time                price price_promotion price_effective
            <int> <dttm>              <dbl>           <dbl>           <dbl>
     1     530290 2020-10-02 04:15:47  50.0            NA              50.0
     2     530290 2020-09-30 03:28:43  50.0            NA              50.0
     3     530290 2020-09-28 04:41:45  50.0            NA              50.0
     4     530290 2020-09-25 03:00:45  50.0            NA              50.0
     5     530290 2020-09-23 01:27:21  50.0            NA              50.0
     6     530290 2020-09-21 04:13:07  50.0            NA              50.0
     7     530290 2020-09-18 03:48:55  50.0            40.0            40.0
     8     530290 2020-09-16 03:26:28  50.0            40.0            40.0
     9     530290 2020-09-14 04:40:09  50.0            40.0            40.0
    10     530290 2020-09-11 03:43:14  50.0            NA              50.0
    # … with 102 more rows, and 1 more variable: available <lgl>

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
