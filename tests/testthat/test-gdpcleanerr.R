
test_that("gdpcleanerr throws an error if not called with any argument",
           {expect_error(gdpcleanerr())})

test_that("gdpcleanerr throws an error if called with a non-dataframe arguement",
           {expect_error(gdpcleaner("Hello"))})


test_that("gdpcleanerr returns a dataframe",
          {
            df = readr::read_csv("test_13100347.csv") |> suppressMessages() |> suppressWarnings()
            out_df = gdpcleanerr(df)
            expect_s3_class(out_df, "data.frame")

          }
)

test_that("gdpcleanerr has at least 5 columns",
          {
            df = readr::read_csv("test_13100347.csv") |> suppressMessages() |> suppressWarnings()
            out_df = gdpcleanerr(df)
           expect_true(ncol(out_df) >= 5)
          }
)

test_that("gdpcleanerr does not return an empty dataframe",
          {
            df = readr::read_csv("test_13100347.csv") |> suppressMessages() |> suppressWarnings()
            out_df = gdpcleanerr(df)
            expect_false(nrow(out_df) == 0)
          }
)


