#' GDP Cleaner
#'This function will strip spurious columns, and Null valued rows, and rename retained columns
#'from any data set from the Open Government Canada Portal that indicates it is a
#'"GDP at Basic Prices" data set (see Data_Sources.csv for examples).
#'
#' @param gdpdata A data frame generated from the Open Government Canada Portal,
#' preferably imported by gdpimporterr
#'
#' @return data.frame A cleaned and simplified data frame
#' @importFrom tidyselect any_of
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
#' df1 <- gdpcleanerr(data)

gdpcleanerr <- function(gdpdata){

    #Check that the argument is correct
    if (is.null(gdpdata)) {
        stop("No argument. Please call gdpcleanerr with a dataframe as the only argument")
    }
    if (!is.data.frame(gdpdata)) {
        stop("Please call gdpcleaner with a dataframe as the only argument")
    }

    #Clear problem names
    names(gdpdata)<-stringr::str_replace_all(names(gdpdata), c(" " = "_" , "," = "_" ))

    #Remove spurious columns and NAs, and rename kept columns
    cleaned_data <- gdpdata |> dplyr::select(-any_of(c("DGUID", "UOM_ID", "SCALAR_ID",
                                                 "VECTOR", "COORDINATE", "STATUS",
                                                  "SYMBOL", "TERMINATED", "DECIMALS",
                                                  "Value", "Seasonal_adjustment"))) |>
                                stats::na.omit() |>
                                dplyr::rename(Date = REF_DATE , Location = GEO,
                                    Scale = SCALAR_FACTOR, Value = VALUE,
                                    Unit = UOM) |> suppressWarnings()


    #Check for NAICS and Aggregates columns
    naics_index <- grep('NAICS', colnames(cleaned_data))
    aggs_index <- grep('aggregat', colnames(cleaned_data))

    #Rename if found
    if (length(naics_index) > 0) {
        cleaned_data <- dplyr::rename(cleaned_data, NAICS_Class = naics_index)
    }

    if (length(aggs_index) > 0) {
      cleaned_data <- dplyr::rename(cleaned_data, Special_Industry = aggs_index)
    }
#Return clean dataframe
cleaned_data
}
