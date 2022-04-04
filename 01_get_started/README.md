
# Sharing pins

User stories:

> As a developer I would like to have a way to share different versions
> of a dataset so that you can try new data without braking old
> analyses.

> As an analyst you would like to have a way to access different
> versions of an evolving dataset so you can compare them.

We can do this with a pins board in a local folder shared via Dropbox.

### Setup

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
```

### Create a pins board in a local folder under \~/Dropbox/

``` r
board <- board_folder("~/Dropbox/pins")
```

### Write a dataset to a pin board

``` r
dataset <- head(mtcars)
board %>% 
  pin_write(dataset, "mtcars")
#> Guessing `type = 'rds'`
#> Creating new version '20220404T202323Z-100f8'
#> Writing to pin 'mtcars'
```

## Read a dataset from a pin board

``` r
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

### Overwrite a dataset in a pin board

``` r
dataset <- head(mtcars, 5)
board %>% 
  pin_write(dataset, "mtcars")
#> Guessing `type = 'rds'`
#> Replacing version '20220404T202323Z-100f8' with '20220404T202323Z-b98a3'
#> Writing to pin 'mtcars'
```

See the [qs](https://CRAN.R-project.org/package=qs) package.

### Write a new version of a dataset to a pin board

Sometimes it’s useful to version pins, so that writing to an existing
pin does not replace the existing data, but instead adds a new copy. You
can activate versioning with `versioned = TRUE`, and you can do it both
for a single pin or for all pins in a board board.

-   Activate versioning for a single pin in a board.

``` r
dataset <- head(iris)
board %>% 
  pin_write(dataset, "iris", versioned = TRUE)
#> Guessing `type = 'rds'`
#> Creating new version '20220404T202323Z-f0793'
#> Writing to pin 'iris'

dataset <- head(iris, 5)
board %>% 
  pin_write(dataset, "iris")
#> Guessing `type = 'rds'`
#> Replacing version '20220404T202323Z-f0793' with '20220404T202323Z-90b16'
#> Writing to pin 'iris'

board %>% 
  pin_versions("iris")
#> # A tibble: 1 × 3
#>   version                created             hash 
#>   <chr>                  <dttm>              <chr>
#> 1 20220404T202323Z-90b16 2022-04-04 17:23:00 90b16
```

-   Activate versioning for all pins in a board.

``` r
board <- board_folder("~/Dropbox/pins", versioned = TRUE)

dataset <- head(mtcars)
board %>% 
  pin_write(dataset, "mtcars")
#> Guessing `type = 'rds'`
#> Creating new version '20220404T202323Z-100f8'
#> Writing to pin 'mtcars'

board %>% 
  pin_versions("mtcars")
#> # A tibble: 2 × 3
#>   version                created             hash 
#>   <chr>                  <dttm>              <chr>
#> 1 20220404T202323Z-100f8 2022-04-04 17:23:00 100f8
#> 2 20220404T202323Z-b98a3 2022-04-04 17:23:00 b98a3
```

### Read a specific version of a dataset from a pin board

``` r
versions <- board %>% 
  pin_versions("mtcars")
versions
#> # A tibble: 2 × 3
#>   version                created             hash 
#>   <chr>                  <dttm>              <chr>
#> 1 20220404T202323Z-100f8 2022-04-04 17:23:00 100f8
#> 2 20220404T202323Z-b98a3 2022-04-04 17:23:00 b98a3

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
#>                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
```
