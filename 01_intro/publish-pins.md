Publish pins
================

``` r
library(pins)
library(pastax.data)
library(here)
#> here() starts at /home/mauro/git/ds.pins

source(here("R", "pins_path.R"))
```

Someone publishes data into a folder on Dropbox. It doesn’t have to be
you.

``` r
board <- board_folder(pins_path())

board %>% 
  pin_write(
    x = head(pastax.data::esa_sme), 
    name = "esa_sme",
    type = "qs", 
    title = "Registered SME v1",
    description = "A demo dataset to show how we might share data.",
    metadata = list(source = "https://esastar-emr.sso.esa.int/"),
    versioned = TRUE
  )
#> Creating new version '20220405T113507Z-58d6d'
#> Writing to pin 'esa_sme'

board %>% 
  pin_write(
    x = pastax.data::esa_sme, 
    name = "esa_sme",
    type = "qs", 
    title = "Registered SME v2",
    description = "A demo dataset to show how we might share data.",
    metadata = list(source = "https://esastar-emr.sso.esa.int/"),
    versioned = TRUE
  )
#> Creating new version '20220405T113507Z-fb4da'
#> Writing to pin 'esa_sme'

board %>% 
  pin_write(
    x = pastax.data::ep_agriculture_livestock, 
    name = "ep_agriculture_livestock",
    type = "qs", 
    title = "Companies in agriculture and livestock",
    description = "A demo dataset to show how we might share data.",
    metadata = list(source = "https://www.europages.co.uk/"),
    versioned = TRUE
  )
#> Creating new version '20220405T113508Z-5eaee'
#> Writing to pin 'ep_agriculture_livestock'
```
