#' Download the zipped file, unzip, rename the unzipped files, and
#' outputs a data frame along with the title from meta data.
#'
#' @param url A character vector with one element: URL to
#' the zip file (ends with .zip)
#' @param filename A character string naming the unzipped
#' csv data (not the MetaData). If `NULL`, 'open_canada_data.csv'
#' will be the filename. This argument is not useful when
#' `filetype` is set to `'all'`
#' @param filetype A character vector with one element: the
#' types of files that will be extracted. If `'csv'`, only csv
#' files are extracted'. If `'all'`, files of all types are extracted
#'
#' @return A list whose first element is a data frame and
#' second element is a character with one element
#' @export
#'
#' @examples
#' gdpimporterr("https://www150.statcan.gc.ca/n1/tbl/csv/36100400-eng.zip")
gdpimporterr <- function(url, filename = NULL, filetype = 'csv') {
}
