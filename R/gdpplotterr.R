#' gpdplotterr
#' Author: Aldo Saltao Barros
#' Plot a line chart of periods and the selected feature.
#' @param cleaned_Dataframe This is the name of the dataset that you want to draw a chart. It is an output from the function gdpcleaner
#' @param aggregation There are two types of aggregation, "canada" and "province". The first one will give the GDP by total Canada. The first one will give the GDP by province.
#'
#' @return line chart of GDP by the Region VS periods.
#' @export
#'
#' @examples
#' df <- readr::read_csv("gdphelperR/36100400.csv")
#' cleaned_df <- gdpcleaner(df)
#' gdpplotterr(cleaned_df)
gdpplotterr <- function(cleaned_Dataframe){

  #Check that the argument is correct
  if (is.null(cleaned_Dataframe)) {
    stop("No argument. Please use gdpcleanerr to get the right arguments for gdpplotter")
  }
  if (!is.data.frame(cleaned_Dataframe)) {
    stop("No DataFrame.Please use gdpcleanerr to get the right arguments for gdpplotter")
  }

  #Check that the argument is correct
  #if(!(typeof(cleaned_Dataframe$Value) == "double")){
  #  stop("Variable Value is not numeric. Please use gdpcleanerr to get the right arguments for gdpplotter")
  #}

  #if(!(typeof(cleaned_Dataframe$Location) == "character")){
  #  stop("Variable Location is not categorical. Please use gdpcleanerr to get the right arguments for gdpplotter")
  #}


  # calling dataFrame
  clened_df <- cleaned_Dataframe

  #listing units in Scale
  units_type <- unique(clened_df$Scale)

  #filtering the right type in Scale
  if ("millions" %in% units_type) {
    #print("check point 1: unity = millions")
    df_filtered <- dplyr::filter(clened_df, Scale == "millions")
  } else if ( "units" %in% units_type) {
    #print("check point 1: unity = units")
    df_filtered <- dplyr::filter(clened_df, Scale == "units")
  } else if ( "units " %in% units_type) {
    #print("check point 1: unity = units-sapce")
    df_filtered <- dplyr::filter(clened_df, Scale == "units ")
  } else {
    stop("This dataframe don't have the GDP's units 'millions' or 'units ' or 'units' which are allowed for this analysis. Please check your DataFrame")
  }

  #checking the variables
  filtered_unids <- unique(df_filtered$Scale)
  #sprintf("Checking filter 01: %s", filtered_unids)
  all_years <- unique(df_filtered$Date)
  #sprintf("year: %s", all_years)
  provinces <- unique(df_filtered$Location)
  #sprintf("%s", provinces)
  total_year <- length(all_years)


  # selecting the charts
  if ( "Canada" %in% provinces && total_year > 1) {
    #print("barchart for Canada")
    df_filtered_2 <- dplyr::filter(df_filtered, Location == "Canada")
    plot_location <- ggplot2::ggplot(df_filtered_2, aes(x = Date, y = Value, color=Location)) +
      geom_bar(stat = 'summary', fun = sum)+
      facet_wrap(~Location, ncol = 5)
    plot_location

  } else if ( "Canada" %in% provinces && total_year == 1) {
    #print("bar chart here!!")
    plot_location <- ggplot2::ggplot(df_filtered, aes(x = Date, y = Value, color=Location)) +
      geom_bar(stat = 'summary', fun = sum)+
      facet_wrap(~Location, ncol = 5)
    plot_location

  } else if ( total_year > 1) {
    #print("chart with multlines goes here")
    plot_location <- ggplot2::ggplot(df_filtered, aes(x = Date, y = Value, color = Location)) +
      geom_line(stat = 'summary', fun = sum)
    plot_location

  } else {
    #print("bar chart for provincies goes here")
    plot_location <- ggplot2::ggplot(df_filtered, aes(x = Date, y = Value, color=Location)) +
      geom_bar(stat = 'summary', fun = sum)+
      facet_wrap(~Location, ncol = 5)
    plot_location

  }



}
