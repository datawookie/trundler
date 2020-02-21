
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

Use `retailers()` to get a list of retailers.

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
retailer(2)
```

``` 
# A tibble: 1 x 4
     id name   url                   currency
  <int> <chr>  <chr>                 <chr>   
1     2 Clicks https://clicks.co.za/ ZAR     
```
