
<!-- README.md is generated from README.Rmd. Please edit that file -->

# retail <img src="man/figures/retail-hex.png" align="right" alt="" width="120" />

[![Travis-CI build
status](https://travis-ci.org/datawookie/retail.svg?branch=master)](https://travis-ci.org/datawookie/retail)
[![Codecov test
coverage](https://img.shields.io/codecov/c/github/datawookie/retail.svg)](https://codecov.io/github/datawookie/retail)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

``` r
library(retail)
```

## Set API Key

To access the full API you’ll need to first specify an API key.

``` r
set_api_key("8f9f6c4e-5dd6-4bff-352c-592b35cf2437")
```

To obtain a key, please get in touch. Contact details are in
`DESCRIPTION`.

## Retailers

Use `retailer()` to get a list of retailers.

``` r
retailer()
```

    # A tibble: 63 x 4
          id name             url                              currency
       <int> <chr>            <chr>                            <chr>   
     1     1 EEM Technologies https://www.eemtechnologies.com/ USD     
     2     2 Clicks           https://clicks.co.za/            ZAR     
     3     3 Dischem          https://www.dischem.co.za/       ZAR     
     4     4 Game             https://www.game.co.za/          ZAR     
     5     5 Woolworths       https://www.woolworths.co.za/    ZAR     
     6     6 Fortnum & Mason  https://www.fortnumandmason.com/ GBP     
     7     7 John Lewis       https://www.johnlewis.com/       GBP     
     8     8 Marks & Spencer  https://www.marksandspencer.com/ GBP     
     9     9 Pick 'n Pay      https://www.pnp.co.za/           ZAR     
    10    10 Makro            https://www.makro.co.za/         ZAR     
    # … with 53 more rows

Or you can acccess the details for a specific retailer.

``` r
retailer(56)
```

``` 
# A tibble: 1 x 4
     id name      url                          currency
  <int> <chr>     <chr>                        <chr>   
1    56 Bloomable https://www.bloomable.co.za/ ZAR     
```

## Products

``` r
retailer_products(56)
```

    # A tibble: 464 x 7
           id retailer_id url                     name          brand sku   barcodes
        <int>       <int> <chr>                   <chr>         <lgl> <chr> <list>  
     1 704031          56 https://www.bloomable.… Decadent Slu… NA    9811  <list […
     2 704032          56 https://www.bloomable.… BOHO-LICIOUS! NA    9863  <list […
     3 760742          56 https://www.bloomable.… Bunch of Lov… NA    1128  <list […
     4 721765          56 https://www.bloomable.… Lush Love - … NA    9487  <list […
     5 760741          56 https://www.bloomable.… Bunch of Lov… NA    1127  <list […
     6 815407          56 https://www.bloomable.… Rose Bowl - … NA    9725  <list […
     7  72540          56 https://www.bloomable.… Merlot & Cho… NA    9865  <list […
     8 852271          56 https://www.bloomable.… White Coffin… NA    10167 <list […
     9 852274          56 https://www.bloomable.… White Coffin… NA    10168 <list […
    10 852272          56 https://www.bloomable.… White Coffin… NA    10166 <list […
    # … with 454 more rows
