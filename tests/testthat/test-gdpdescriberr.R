test_that("Valid arguments", {
  df2 = read.csv("test_13100347.csv")
  .stats = c('mean', 'median', 'sd')
  expect_s3_class(df2, "data.frame")
  expect_true(all(.stats %in% c('mean', 'median', 'sd', 'min', 'max', 'range' , "q75", "q25", "iqr", "nas")))
  expect_type(df2 |> select(VALUE) |>dplyr::pull(),"double")
  expect_type(df2 |> select(Sex) |> dplyr::pull,"character")
  expect_lt(df2 |> select(Sex) |> dplyr::n_distinct(), df2 |> nrow())
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
