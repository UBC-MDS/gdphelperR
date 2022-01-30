test_that("The object is not a dataframe",
          {expect_error(gdpdescriberr(c(1,3,4,5), x=Value, y=Location))})

test_that("Error: Variable Y has values in every row",{
          df2 = utils::read.csv("test_13100347.csv")
          expect_error(gdpdescriberr(df2, x=VALUE, y=VECTOR))
          })

test_that("Variable X is not numeric",{
          df2 = utils::read.csv("test_13100347.csv")
          expect_error(gdpdescriberr(df2, x=GEO, y=VALUE))
          })


test_that("Variable Y is not categorical", {
          df2 = utils::read.csv("test_13100347.csv")
          expect_error(gdpdescriberr(df2, x=VALUE, y=UOM_ID))
          })


test_that("The statistic to calculate is not correct! Please enter a valid one",{
          df2 = utils::read.csv("test_13100347.csv")
          expect_error(gdpdescriberr(df2, x=VALUE, y=GEO, .stats = c('mean', 'median', 'sd', "bla")))
          })

test_that("Valid arguments", {
  df2 = utils::read.csv("test_13100347.csv")
  .stats = c('mean', 'median', 'sd')
  expect_s3_class(df2, "data.frame")
  expect_true(all(.stats %in% c('mean', 'median', 'sd', 'min', 'max', 'range' , "q75", "q25", "iqr", "nas")))
  expect_type(df2 |> dplyr::select(VALUE) |>dplyr::pull(),"double")
  expect_type(df2 |> dplyr::select(Sex) |> dplyr::pull(),"character")
  expect_lt(df2 |> dplyr::select(Sex) |> dplyr::n_distinct(), df2 |> nrow())
})


test_that("Correct Values", {

  test_df = tibble::tibble(
    "col1" = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
    "col2" = c("F", "F", "F", "F", "F", "M", "M", "M", "M", "M")
  )

  results = gdpdescriberr(test_df, x=col1, y=col2, dec=0, .stats=c("min", "max", "mean"))
  expect_equal(results[[2,2]] |> as.numeric(), 1)
  expect_equal(results[[2,3]] |> as.numeric(), 2)
  expect_equal(results[[4,2]] |> as.numeric(), 1)
  expect_equal(results[[4,3]] |> as.numeric(), 2)
})
