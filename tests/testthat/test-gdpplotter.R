

test_that("inputs are good to go", {
  df = readr::read_csv("test_13100347.csv")
  expect_type(typeof(df$VALUE),"character")
  expect_type(typeof(df$GEO),"character")
  expect_type(typeof(df$REF_DATE),"character")
})


test_that("ggplot2 works", {
  df = readr::read_csv("test_13100347.csv")
  cleaned_Dataframe <- gdpcleanerr(df)
  p <- gdpplotterr(cleaned_Dataframe)
  vdiffr::expect_doppelganger("default histogram", p)
})
