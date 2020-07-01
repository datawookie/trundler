## Test environments

* Local Ubuntu 18.04, R 3.6.3
* win-builder (devel and release)

## Testing Locally

```r
rhub::check_for_cran()
```

## R CMD check results

There were no ERRORs, WARNINGs or NOTEs. 

- Most of the examples and tests are set to not run or skip on CRAN as they require an API key and database credentials.
