#' Create Echart Map From GADM Map
#'
#' Get json map for echart4r on the town level
#'
#' @param country Choose the country, default is Vietnam
#'
#' @param town character vector, list all the town want to be included in the map
#' @return a json map ready to feed echarts4r::e_map_register()
#' @importFrom geojsonio geojson_list
#' @importFrom raster getData
#' @import purrr
#' @export

custom_echart_town <- function(country = "Vietnam", town){
  ## create data
  if (!dir.exists("./data-GADM")) dir.create("./data-GADM")
  ## raster data
  country <- raster::getData("GADM", country = country, level = 2, path = "./data-GADM")

  ## filter the location
  town <- country[country$NAME_1 %in% town,]

  ## rename
  names(town)[7]<- "name"

  ## convert to json map
  geojson_map <- geojsonio::geojson_list(town)

  ## show the choosen town
  chosen_region <- map_chr(seq_along(geojson_map$features), ~pluck(geojson_map, "features", .x, "properties", "name"))

  ## return result
  list(map = geojson_map, region = chosen_region)


}
