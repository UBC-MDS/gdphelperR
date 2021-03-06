#' GDP describerr
#' Calculates summary statistics for the Numeric Variable x grouping by categorical variable y.
#' The function is able to calculate the following descriptive statistics:
#'Mean
#'Median
#'Standard Deviation
#'Minimum Value
#'Maximum Value
#'Range
#'Value of 75th percentile
#'Value of 25th percentile
#'Interquartile range
#'Number of Missing values
#' @param df1  cleaned data frame preprocessed by gdpcleanerr
#' @param x  column name of a data frame used to calculate the descriptive statistics
#' @param y  column name of a grouping variable
#' @param .stats vector with the descriptive stats to calculate
#' @param dec number of decimal places to return in the table
#'
#' @return data.frame
#' @importFrom rlang :=
#' @export
#'
#' @examples
#' data <- tibble::tribble(~REF_DATE,~GEO,~DGUID,
#' ~`North.American.Industry.Classification.System.(NAICS)`,
#' ~UOM, ~UOM_ID,~SCALAR_FACTOR,~SCALAR_ID,~VECTOR, ~COORDINATE,
#' ~VALUE,~STATUS,~SYMBOL,~TERMINATED,~DECIMALS,1997L,"Canada",
#' "2016A000011124","Total industries", "Dollars",81L,"millions",
#' 6L, "v41894235",1.477, 816756.1, NA,NA, NA,1L,1997L,"Canada",
#' "2016A000011124", "Crop and animal production",
#' "Dollars",81L,"millions",6L,"v41700857", 1.1,12755.9,NA,NA, NA,1L)
#' gdpdescriberr(data, VALUE, GEO, .stats=c("mean", "sd", "median"), dec = 2)


gdpdescriberr = function(df1, x, y, .stats=c("mean", "sd", "median"), dec = 2){
  # library(dplyr)
  options(warn = -1)

  if(!is.data.frame(df1)){
    stop("The object is not a dataframe")
  }

  if (df1 |> dplyr::select({{y}}) |> dplyr::n_distinct() >=nrow(df1)){
    stop("Error: Variable Y has values in every row")
  }

  if(!is.numeric(df1 |> dplyr::select({{x}}) |> dplyr::pull())){
    stop("Variable X is not numeric")
  }

  if(!is.character(df1 |> dplyr::select({{y}}) |> dplyr::pull())){
    stop("Variable Y is not categorical")
  }


  if(!(all(.stats %in% c('mean', 'median', 'sd', 'min', 'max', 'range' , "q75", "q25", "iqr", "nas")))){
    stop("The statistic to calculate is not correct! Please enter a valid one")
  }

  e1 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( mean := mean({{ x }},  na.rm = T))

  e2 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( median := median({{ x }},  na.rm = T))

  e3 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( sd := stats::sd({{ x }},  na.rm = T))

  e4 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( min := min({{ x }},  na.rm = T))

  e5 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( max := max({{ x }},  na.rm = T))

  e6 = df1 |>
    dplyr::group_by({{ y }}) |>
    dplyr::summarise( range :=  max({{ x }}, na.rm = T) - min({{ x }}, na.rm = T))

  e7 = df1 |> dplyr::group_by({{ y }}) |>
    dplyr::summarise(q75 := stats::quantile({{ x }}, .75, na.rm=T))

  e8 = df1 |> dplyr::group_by({{ y }}) |>
    dplyr::summarise(q25 := stats::quantile({{ x }}, .25, na.rm=T))

  e9 = df1 |> dplyr::group_by({{ y }}) |>
    dplyr::summarise(iqr := stats::IQR({{ x }}, na.rm=T))

  e10 = df1 |> dplyr::group_by({{ y }}) |>
    dplyr::summarise(nas = sum(is.na({{x}})))

  .all.stats = c('mean', 'median', 'sd', 'min', 'max', 'range' , "q75", "q25", "iqr", "nas")
  .all.stats.o = paste0("e", 1:length(.all.stats))


  .res = e1[,1]
  for (.x in .stats){
    .w = which(.all.stats %in% .x)
    .r = get(.all.stats.o[.w])[,2]
    .r = round(.r, dec)
    .res = cbind(.res,.r)
  }

  return(tibble::as_tibble(cbind(colnames(.res),t(.res))) )
  options(warn = getOption("warn"))
}
