test_gdpdescriberr = function(){
  
  df2 = read.csv("test_13100347.csv")
  
  .stats = c('mean', 'median', 'sd')
  
  gdpdescribe(df1 = df2, x=VALUE, y=Sex, .stats=.stats, dec = 2)
  
  
  
  test_that("df should be a data.frame", {
    expect_s3_class(df2, "data.frame")
  })
  
  
  test_that("Valid Stat", {
    expect_true(all(.stats %in% c('mean', 'median', 'sd', 'min', 'max', 'range' , "q75", "q25", "iqr", "nas")))
  })
  
  
  test_that("X is numeric", {
    expect_type(df2 %>% select(VALUE) %>% pull(),"double")
  })
  
  test_that("Y is categorical", {
    expect_type(df2 %>% select(Sex) %>% pull(),"character")
  })
  
  test_that("Y is not unique", {
    expect_lt(df2 %>% select(Sex) %>% n_distinct(), df2%>% nrow())
  })
  
  
  test_df = tibble(
    "col1" = c(1, 1, 1, 1, 1, 2, 2, 2, 2, 2),
    "col2" = c("F", "F", "F", "F", "F", "M", "M", "M", "M", "M")
  )
  
  results = gdpdescribe(test_df, x=col1, y=col2, dec=0, .stats=c("min", "max", "mean"))
  
  test_that("Correct Value", {
    expect_equal(results[2,2] %>% pull() %>% as.numeric(), 1)
  })
  
  test_that("Correct Value", {
    expect_equal(results[2,3] %>% pull() %>% as.numeric(), 2)
  })
  
  test_that("Correct Value", {
    expect_equal(results[4,2] %>% pull()%>% as.numeric(), 1)
  })
  
  test_that("Correct Value", {
    expect_equal(results[4,3] %>% pull() %>% as.numeric(), 2)
  })
  
}