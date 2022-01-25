#' GDP Cleaner
#' Author: Gabe Fairbrother
#'This function will strip spurious columns, and Null valued rows, and rename retained columns
#'from any data set from the Open Government Canada Portal that indicates it is a
#'"GDP at Basic Prices" data set (see Data_Sources.csv for examples).
#'
#' @param data.frame A data frame generated from the Open Government Canada Portal, preferably imported by gdpimporter
#'
#' @return data.frame A cleaned and simplified data frame
#' @export
#'
#' @examples
#' df <- gdpcleanerr(data)
gdpcleanerr <- function(data_frame){

    #Check that the argument is correct
    if is.null(data_frame) {
        stop("No argument. Please call gdpcleanerr with a dataframe as the only argument")
    }
    if !is.data_frame(data_frame) {
        stop("Please call gdpcleaner with a dataframe as the only argument")
    }

    #Remove spurious columns and NAs, and rename kept columns
    cleaned_frame <- gdpdata |> subset(mydata, select = -c(DGUID, UOM_ID, SCALAR_ID, 
                                                        VECTOR, COORDINATE, STATUS, 
                                                        SYMBOL, TERMINATED, DECIMALS, 
                                                        Value, `Seasonal adjustment`)) |>
                                na.omit() |>
                                dplyr::rename(Date = REF_DATE , Location = GEO, 
                                    Scale = SCALAR_FACTOR, Value = VALUE, 
                                    Unit = UOM) 

    #Check for NAICS and Aggregates columns
    naics_index = grepl('NAICS', colnames(cleaned_frame))
    aggs_index = grepl('aggregat', colnames(cleaned_frame))

    #Rename if found
    if naics_index is not NULL {
        rename(cleaned_frame, NAICS_Class = naics_index)
    }

    if aggs_index is not NULL {
        rename(cleaned_frame, Special_Industry = aggs_index)
    }
#Return clean dataframe
cleaned_frame                             
}
