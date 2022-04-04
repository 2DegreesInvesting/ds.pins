
# Sharing pins

Use case:

-   As a developer I would like to have a way to share with you each
    version of an evolving dataset so I can get feedback from you.

-   As an analyst you would like to have a way to analyze each version
    of an evolving dataset so you can give feedback to me.

We share the multiple versions of the dataset with a pins board in a
shared Dropbox folder.

### `pin_write()` with defaults

I use `pin_write()` to write data to a shared pins board.

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

board <- board_folder("~/Dropbox/pins")
data <- head(mtcars)

board %>% 
  pin_write(data, "mtcars")
#> Guessing `type = 'rds'`
#> Creating new version '20220404T183145Z-100f8'
#> Writing to pin 'mtcars'
```

### `pin_read()`

You use `pin_read()` to read data from a shared pins board.

``` r
library(pins)

board <- board_folder("~/Dropbox/pins")

board %>% 
  pin_read("mtcars")
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

### `pin_write()` with `type = "qs"`

Now I use `type = "qs"` to replace the pin with a faster, smaller
version ([qs](https://CRAN.R-project.org/package=qs)).

``` r
board %>% 
  pin_write(data, "mtcars", type = "qs")
#> Replacing version '20220404T183145Z-100f8' with '20220404T183145Z-3fa28'
#> Writing to pin 'mtcars'
```

The original “.rds” file is gone. It was replaced with the “.qs”
version. But sometimes it’s useful to version pins, so that writing to
an existing pin does not replace the existing data, but instead adds a
new copy.

### `versioned = TRUE` and `pin_versions()`

I use `versioned = TRUE` to activate versioning.

``` r
board <- board_folder("~/Dropbox/pins", versioned = TRUE)
```

I can now share multiple versions of the same dataset.

``` r
new_data <- rownames_to_column(data)

board %>% 
  pin_write(new_data, "mtcars")
#> Guessing `type = 'rds'`
#> Creating new version '20220404T183145Z-965f3'
#> Writing to pin 'mtcars'

board %>% 
  pin_versions("mtcars")
#> # A tibble: 2 × 3
#>   version                created             hash 
#>   <chr>                  <dttm>              <chr>
#> 1 20220404T183145Z-3fa28 2022-04-04 15:31:00 3fa28
#> 2 20220404T183145Z-965f3 2022-04-04 15:31:00 965f3
```

### `version`

You can now read a specific `version` of the data.

``` r
versions <- board %>% 
  pin_versions("mtcars")
versions
#> # A tibble: 2 × 3
#>   version                created             hash 
#>   <chr>                  <dttm>              <chr>
#> 1 20220404T183145Z-3fa28 2022-04-04 15:31:00 3fa28
#> 2 20220404T183145Z-965f3 2022-04-04 15:31:00 965f3

board %>%
  pin_read("mtcars", version = versions$version[[1]])
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

board %>%
  pin_read("mtcars", version = versions$version[[2]])
#>             rowname  mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> 1         Mazda RX4 21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> 2     Mazda RX4 Wag 21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> 3        Datsun 710 22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> 4    Hornet 4 Drive 21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> 5 Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> 6           Valiant 18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

``` r
# Cleanup
fs::dir_delete("~/Dropbox/pins")
```
