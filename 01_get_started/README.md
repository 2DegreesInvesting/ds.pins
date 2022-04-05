Share data as pins with Dropbox
================

We might share different versions of evolving data as
[pins](https://pins.rstudio.com/) with Dropbox.

### Publish pins

Someone publishes data into a folder on Dropbox. It doesn’t have to be
you.

### Use pins

-   You have the shared Dropbox folder locally in your computer and in
    sync.

-   You know the path to that folder or have a helper function.

``` r
# Someone wrote this function. It doesn't have to be you.
pins_path()
#> /home/mauro/Dropbox (2° Investing)/2° Team/People/Mauro/pins
```

-   Use the [pins](https://pins.rstudio.com/) package. I also use the
    tidyverse for convenience.

-   Define the pins board you’ll use.

``` r
library(tidyverse, warn.conflicts = FALSE)
#> ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──
#> ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
#> ✓ tibble  3.1.6     ✓ dplyr   1.0.8
#> ✓ tidyr   1.2.0     ✓ stringr 1.4.0
#> ✓ readr   2.1.2     ✓ forcats 0.5.1
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
library(pins)

board <- board_folder(pins_path())
```

-   Read the latest version of a pin.

``` r
board %>% 
  pin_read("esa_sme")
#> # A tibble: 775 × 23
#>    page_id details_id name              country_of_regi… entity_type entity_size
#>    <chr>   <chr>      <chr>             <chr>            <chr>       <chr>      
#>  1 1       128211     1D works UG       DE-Germany       Company     TBD        
#>  2 1       129014     1st-Relief GmbH   AT-Austria       Company     TBD        
#>  3 1       69691      3DiS Technologies FR-France        Company     TBD        
#>  4 10      82990      Algentech SAS     FR-France        Company     TBD        
#>  5 10      59896      ALONG-TRACK       FR-France        Company     TBD        
#>  6 10      82778      AlphaLink Engine… DE-Germany       Company     TBD        
#>  7 100     85687      Permagro          FR-France        Company     TBD        
#>  8 100     84086      Petabite GmbH     DE-Germany       Company     Micro      
#>  9 101     86708      Piql Iberia S.L.  ES-Spain         Company     TBD        
#> 10 101     67623      PIXSTART          FR-France        Company     TBD        
#> # … with 765 more rows, and 17 more variables: esastar_status <chr>,
#> #   description <chr>, entity_id <chr>, nationality_desc <chr>,
#> #   entity_code <chr>, entity_vat_number <chr>, entity_sme_status <chr>,
#> #   entity_type_desc <chr>, entity_size_desc <chr>, address <chr>,
#> #   number <chr>, city <chr>, postal_code <chr>, phone <chr>, entity_fax <chr>,
#> #   entity_mail <chr>, entity_web_site <chr>
```

-   List all pins published into the shared board.

``` r
board %>% 
  pin_list()
#> [1] "ep_agriculture_livestock" "esa_sme"
```

-   Explore the available versions of one specific dataset.

``` r
versions <- board %>% 
  pin_versions("esa_sme")

versions
#> # A tibble: 46 × 3
#>    version                created             hash 
#>    <chr>                  <dttm>              <chr>
#>  1 20220404T222149Z-58d6d 2022-04-04 19:21:00 58d6d
#>  2 20220404T222149Z-fb4da 2022-04-04 19:21:00 fb4da
#>  3 20220404T231123Z-58d6d 2022-04-04 20:11:00 58d6d
#>  4 20220404T231123Z-fb4da 2022-04-04 20:11:00 fb4da
#>  5 20220404T231427Z-58d6d 2022-04-04 20:14:00 58d6d
#>  6 20220404T231427Z-fb4da 2022-04-04 20:14:00 fb4da
#>  7 20220404T231614Z-58d6d 2022-04-04 20:16:00 58d6d
#>  8 20220404T231614Z-fb4da 2022-04-04 20:16:00 fb4da
#>  9 20220404T231708Z-58d6d 2022-04-04 20:17:00 58d6d
#> 10 20220404T231708Z-fb4da 2022-04-04 20:17:00 fb4da
#> # … with 36 more rows
```

-   Explore the metadata for a version of a pin.

``` r
version <- versions %>% 
  slice(2) %>% 
  pull(version)
version
#> [1] "20220404T222149Z-fb4da"

board %>% 
  pin_meta("esa_sme", version)
#> List of 11
#>  $ file       : chr "esa_sme.qs"
#>  $ file_size  : 'fs_bytes' int 240K
#>  $ pin_hash   : chr "fb4dade1ce6e35f1"
#>  $ type       : chr "qs"
#>  $ title      : chr "Registered SME v2"
#>  $ description: chr "A demo dataset to show how we might share data."
#>  $ created    : POSIXct[1:1], format: "2022-04-04 19:21:00"
#>  $ api_version: num 1
#>  $ user       :List of 1
#>   ..$ source: chr "https://esastar-emr.sso.esa.int/"
#>  $ name       : chr "esa_sme"
#>  $ local      :List of 3
#>   ..$ dir    : 'fs_path' chr "/home/mauro/Dropbox (2° Investing)/2° Team/People/Mauro/pins/esa_sme/20220404T222149Z-fb4da"
#>   ..$ url    : NULL
#>   ..$ version: chr "20220404T222149Z-fb4da"
```

-   Read a specific version.

``` r
board %>% 
  pin_read("esa_sme", version)
#> # A tibble: 775 × 23
#>    page_id details_id name              country_of_regi… entity_type entity_size
#>    <chr>   <chr>      <chr>             <chr>            <chr>       <chr>      
#>  1 1       128211     1D works UG       DE-Germany       Company     TBD        
#>  2 1       129014     1st-Relief GmbH   AT-Austria       Company     TBD        
#>  3 1       69691      3DiS Technologies FR-France        Company     TBD        
#>  4 10      82990      Algentech SAS     FR-France        Company     TBD        
#>  5 10      59896      ALONG-TRACK       FR-France        Company     TBD        
#>  6 10      82778      AlphaLink Engine… DE-Germany       Company     TBD        
#>  7 100     85687      Permagro          FR-France        Company     TBD        
#>  8 100     84086      Petabite GmbH     DE-Germany       Company     Micro      
#>  9 101     86708      Piql Iberia S.L.  ES-Spain         Company     TBD        
#> 10 101     67623      PIXSTART          FR-France        Company     TBD        
#> # … with 765 more rows, and 17 more variables: esastar_status <chr>,
#> #   description <chr>, entity_id <chr>, nationality_desc <chr>,
#> #   entity_code <chr>, entity_vat_number <chr>, entity_sme_status <chr>,
#> #   entity_type_desc <chr>, entity_size_desc <chr>, address <chr>,
#> #   number <chr>, city <chr>, postal_code <chr>, phone <chr>, entity_fax <chr>,
#> #   entity_mail <chr>, entity_web_site <chr>
```
