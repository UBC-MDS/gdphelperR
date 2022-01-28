test_that("test the return type of gdpimporterr", {
  out_list = gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.zip")
  out_df = out_list[[1]]
  out_str = out_list[[2]]
  expect_s3_class(out_df, "data.frame")
  expect_equal(out_str, 'Gross domestic product (GDP) at basic prices, by industry, provinces and territories, percentage share')
})

test_that("test if gdpimporterr unzips the file and rename the csv as expected", {
  gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.zip")
  # if filename is not specified
  expect_true("open_canada_data.csv" %in% dir())
  # if filename is specified
  gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100401-eng.zip", filename='gdp_census')
  expect_true("gdp_census.csv" %in% dir())
})

test_that("test if gdpimporter unzips files without further renaming them", {
  gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100401-eng.zip", filetype='all')
  expect_true("36100401.csv" %in% dir())
})

test_that("function should throw an error when 'filename' is not None (default) or a string", {
  expect_error(gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.zip", filename=list('gdp2021_data')))
})

test_that("function should throw an error when 'filetype' is not 'csv' or 'all'", {
  expect_error(gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.zip", filetype='dat'))
})

test_that("function should throw an error when 'url' is not valid", {
  expect_error(gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.csv", filename='gdp2021_data'))
})
