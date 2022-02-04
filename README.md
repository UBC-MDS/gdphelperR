
<!-- README.md is generated from README.Rmd. Please edit that file -->

# gdphelperR

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/gdphelperR/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/gdphelperR/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/gdphelperR/branch/main/graph/badge.svg?token=GD7QfWZIw5)](https://codecov.io/gh/UBC-MDS/gdphelperR)
<!-- badges: end -->

The goal of gdphelperR is to take the url of any of the several dozen GDP-related csv datasets from the Canadian Government Open Data Portal and download, clean load, summarize and visualize the data contained within.

- `gdpimporterr`: Downloads the zipped data, extracts, renames the appropriate csv, and returns a dataframe along with the title from the meta data.  
- `gdpcleanerr`: Loads the data, removes spurious columns, renames used columns, scrubs and data issues. Returns a basic data frame and some category flags.  
- `gdpdescriberr` : Evaluates the data category and generates summary statistics by year, region, industry, etc.  
- `gdpplotterr`: Generates a set of visualizations of the data set according to the user's choices. 

This package is built upon a bunch of popular packages in R ecosystem, including `ggplot`, `dplyr` and other packages in the `tidyverse`. What makes this package unique is that it incorporates the common functionalities and streamlines the workflow from downloading the data to performing simple EDA, specifically for the GDP-related data from the Canadian Government Open Data Portal.


## Installation

You can install the released version of gdphelperR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/gdphelperR")
```

## Usage

to import our package:
``` r
library(gdphelperR)
```
For a detailed usage example, please refer to our vignette:
https://ubc-mds.github.io/gdphelperR/articles/my-vignette.html


## Contributors

-   Aldo Barros <aldosaltao@gmail.com>
-   Gabe Fairbrother <gfairbrother@gmail.com>
-   Wanying Ye <wanying.ye2020@gmail.com>
-   Ramiro Mejia <ramiromejiap@gmail.com>

## Contributing

Interested in contributing? Check out the [contributing
guidelines](https://github.com/UBC-MDS/Group_03_GOV_CA_GDP_HELPER/blob/main/CONTRIBUTING.md).

## Code of Conduct

Please note that the gdphelperR project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.

## License

`gdphelperR` was created by Aldo Barros, Gabriel Fairbrother, Ramiro
Mejia, Wanying Ye. It is licensed under the terms of the MIT license.
