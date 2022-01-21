# Contributing to gdphelperR

This outlines how to propose a change to gdphelperR. 
For more detailed info about contributing to this, and other tidyverse packages, please see the
[**development contributing guide**](https://rstd.io/tidy-contrib). 

## How to contribute

### Reporting bugs

If you are reporting a bug, please include:

- Your operating system name and version.
- Any details about your local setup that might be helpful in troubleshooting.
- Detailed steps to reproduce the bug.

### Fixing bugs

It's a good idea to first file an issue and make sure someone from the team agrees that it’s needed. 
If you’ve found a bug, please file an issue that illustrates the bug with a minimal 
[reprex](https://www.tidyverse.org/help/#reprex) (this will also help you write a unit test, if needed).

### For project maintainer team

We follow GitHub flow to contribute to this `gdphelperR`. Steps include:

- Work on a branch.
- Commit changes.
- Create a pull request.
- At least one maintainer should review the changes and make decisions on whether approve or request further changes.
- Upon approval, the pull request is merged.

### For new contributors

Contributions are welcome, and they are greatly appreciated! Every little bit helps, and credit will always be given.

- Fork the package and clone onto your computer. If you haven't done this before, we recommend using `usethis::create_from_github("UBC-MDS/gdphelperR", fork = TRUE)`.

- Install all development dependences with `devtools::install_dev_deps()`, and then make sure the package passes R CMD check by running `devtools::check()`. 
    If R CMD check doesn't pass cleanly, it's a good idea to ask for help before continuing. 
- Create a Git branch for your pull request (PR). We recommend using `usethis::pr_init("brief-description-of-change")`.

- Make your changes, commit to git, and then create a PR by running `usethis::pr_push()`, and following the prompts in your browser.
    The title of your PR should briefly describe the change.
    The body of your PR should contain `Fixes #issue-number`.

- For user-facing changes, add a bullet to the top of `NEWS.md` (i.e. just below the first header). Follow the style described in <https://style.tidyverse.org/news.html>.

### Code style

*   New code should follow the tidyverse [style guide](https://style.tidyverse.org). 
    You can use the [styler](https://CRAN.R-project.org/package=styler) package to apply these styles, but please don't restyle code that has nothing to do with your PR.  

*  We use [roxygen2](https://cran.r-project.org/package=roxygen2), with [Markdown syntax](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html), for documentation.  

*  We use [testthat](https://cran.r-project.org/package=testthat) for unit tests. 
   Contributions with test cases included are easier to accept.  

## Code of Conduct

Please note that the gdphelperR project is released with a
[Contributor Code of Conduct](https://github.com/UBC-MDS/gdphelperR/blob/doc-contributing-edit/CODE_OF_CONDUCT.md). 
By contributing to this project you agree to abide by its terms.
