#' Download the zipped file, unzip, rename the unzipped files, and
#' outputs a data frame along with the title from meta data.
#'
#' @param url A character vector with one element: URL to
#' the zip file (ends with .zip)
#' @param filename A character vector with one element: specify
#' the name of csv data (not the MetaData). If `NULL`,
#' 'open_canada_data.csv' will be the filename.
#' This argument is not useful when `filetype` is set to `'all'`
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
  # Exception Handling:
  if (!is.null(filename) & (!is.character(filename))) {
    stop("'filename' should be either None (default) or a string")
  }
  if (!filetype %in% list('csv', 'all')) {
    stop("'filetype' should either be 'csv' (by default) or 'all'")
  }
  if (!is.character(url) | length(url) != 1 | substr(url, nchar(url) - 3, nchar(url)) != '.zip') {
    stop("'url' should be a valid url of a zipfile that ends with '.zip'")
  }

  utils::download.file(url, "zipfolder_oc.zip")
  info = utils::unzip("zipfolder_oc.zip", list=TRUE)
  utils::unzip("zipfolder_oc.zip")

  if (filetype == "csv") {
    for (file in info$Name) {
      # find the metadata
      if ("MetaData.csv" == substr(file, nchar(file) - 11, nchar(file))) {
        metadata_path = file
      } else if (".csv" == substr(file, nchar(file) - 3, nchar(file))) {
        # this will do the renaming
        if (is.null(filename)) {
          file.rename(file, "open_canada_data.csv")
          data_path = "open_canada_data.csv"
        } else {
          # must be a string
          file.rename(file, paste0(filename, ".csv"))
          data_path = paste0(filename, ".csv")
        }
      }
    }
    # Clean up the unuseful files
    file.remove("zipfolder_oc.zip")
    for (file in info$Name) {
      if (".csv" != substr(file, nchar(file) - 3, nchar(file))) {
        file.remove(file)
      }
    }

  } else {
    for (file in info$Name) {
      # find the metadata
      if ("MetaData.csv" == substr(file, nchar(file) - 11, nchar(file))) {
        metadata_path = file
      } else if (".csv" == substr(file, nchar(file) - 3, nchar(file))) {
        data_path = file
      }
    }

  }

  metadata = readr::read_csv(metadata_path) |> suppressMessages() |> suppressWarnings()
  data = readr::read_csv(data_path) |> suppressMessages()
  # Clean up the metadata
  file.remove(metadata_path)
  # return a list
  list(data, metadata$`Cube Title`[1])
}
