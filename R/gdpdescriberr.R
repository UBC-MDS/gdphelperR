#' GDP describerr
#' Calculates summary statistics for the Numeric Variable x grouping by categorical variable y.
#'     The function is able to calculate the following descriptive statistics:
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
#' @param data.frame cleaned data frame preprocessed by gdpcleanerr
#' @param x  column name of a data frame used to calculate the descriptive statistics
#' @param y  column name of a grouping variable
#' @param stats vector with the descriptive stats to calculate
#' @param dec   number of decimal places to return in the table
#'
#' @return
#' @export
#'
#' @examples
#' gdpdescriberr(df, "GDP", "year", stats=c("mean", "median", "sd", "min", "max", "range_"), dec=2)
gdpdescriberr  <- function(data.frame, x, y, stats=c("mean", "sd", "median"), dec=2){

}
