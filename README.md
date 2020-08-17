
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
       product_id product                                   brand   model sku       
            <int> <chr>                                     <chr>   <chr> <chr>     
     1    2702204 Alexandra Mule                            Witche… <NA>  933835874…
     2    2702216 Nettie Woven Sneaker                      Trenery <NA>  935453004…
     3    2702223 Paisley Swim Short                        Trenery <NA>  933835895…
     4    2702224 Orla Suede Flat Orla Suede Flat           Witche… <NA>  934024397…
     5    2702227 Summer Sunglasses                         Witche… <NA>  932426867…
     6    2702229 Windowpane Jacket                         Trenery <NA>  933835846…
     7    2702235 Micro Textured Blazer                     Trenery <NA>  934024399…
     8    2702239 Fern Textured Heel Fern Textured Heel     Witche… <NA>  935453012…
     9    2702245 Flax Linen Blazer                         Trenery <NA>  933835846…
    10    2873780 Total Support DD+ Moulded Non-wire Bra -… <NA>    <NA>  600918468…
    # … with 203,567 more rows

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
       product_id retailer_id product                   brand    model sku          
            <int>       <int> <chr>                     <chr>    <chr> <chr>        
     1    2937578           5 BATH TIME Hand Sanitiser… W Bath&… <NA>  6009211275256
     2    2917403           2 Hi Five Hand Sanitiser 5… Motley … <NA>  336382       
     3    2922878         109 Hand Sanitiser            Rubi     <NA>  422260-03    
     4    2923002           9 Sanamed Hand Sanitiser 1l <NA>     <NA>  000000000000…
     5    2923003           9 Sanamed Hand Sanitiser 1… <NA>     <NA>  000000000000…
     6    2923063           4 Puridene Waterless Hand … TEVO     <NA>  00813161     
     7    2923064           4 Handex Hand Sanitiser - … SHIELD   SH13… 00813831     
     8    2923072           4 Puridene Waterless Hand … TEVO     <NA>  00812664     
     9    2923073           4 Puridene Waterless Hand … TEVO     <NA>  00812663     
    10    2923074           4 Puridene Waterless Hand … TEVO     <NA>  00812630     
    # … with 287 more rows

``` r
products(product = "coffee", brand = "nespresso|nescafe")
```

    # A tibble: 307 x 6
       product_id retailer_id product                 brand   model     sku         
            <int>       <int> <chr>                   <chr>   <chr>     <chr>       
     1    2918572           5 Creatista Plus Coffee … Nespre… <NA>      76300396488…
     2    2918582           5 Citiz&Milk Coffee Mach… Nespre… <NA>      76300544309…
     3    2918584           5 Lattissima One Coffee … Nespre… <NA>      76300396464…
     4    2918599           5 Essenza Mini Coffee Ma… Nespre… <NA>      76300396187…
     5    2918601           5 Lattissima Touch Coffe… Nespre… <NA>      76300476151…
     6    3244171           4 Nescafe Ricoffy Coffee… Nescafe <NA>      320548-EA   
     7    2932252          10 Nespresso CitiZ & Milk… NESPRE… C123-ZA-… 00000000000…
     8    2951781          10 Nespresso Lattissima O… NESPRE… F111-ZA-… 00000000000…
     9    2951782          10 Nespresso Essenza Mini… NESPRE… C30-ZA-B… 00000000000…
    10       2383          30 Nescafe Gold Blend Ins… Nescafe <NA>      380351011   
    # … with 297 more rows

``` r
products(product = "tv", brand = "samsung|hisense")
```

    # A tibble: 1,731 x 6
       product_id retailer_id product                      brand  model  sku        
            <int>       <int> <chr>                        <chr>  <chr>  <chr>      
     1    2916173          47 "Samsung 139cm (55\") QLED … Samsu… <NA>   69172S     
     2    2916168          46 "Samsung 55 Inch UHD 4K Cur… Samsu… <NA>   UA55RU7300 
     3    2916287          47 "Samsung 139cm (55\") QLED … Samsu… <NA>   69172S     
     4    2917132          47 "Samsung 139cm (55\") QLED … Samsu… <NA>   69172S     
     5    2916174          46 "Hisense 32 Inch HD Smart T… Hisen… <NA>   32B6000    
     6    2916203          47 "Samsung 109cm(43\") UHD 4K… Samsu… <NA>   67653      
     7    2917663          47 "Samsung 139cm (55\") QLED … Samsu… <NA>   69172S     
     8    2917677          47 "Samsung 109cm(43\") UHD 4K… Samsu… <NA>   67653      
     9    2968283          10 "Hisense 108 cm (43\") Full… HISEN… 43B52… 0000000000…
    10    2923008           4 "75\" UHD TV"                SAMSU… 75NU7… 00787370   
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
