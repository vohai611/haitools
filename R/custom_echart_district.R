#' Create Echart Map From GADM Map
#'
#' Get json map for echart4r on the district level
#'
#' @param country Choose the country, default is Vietnam
#'
#' @param district Character vector, list all the district want to be included in the map
#'
#' @return a json map ready to feed echarts4r::e_map_register()
#' @export

custom_echart_district <- function(country = "Vietnam", district) {
  # create directory for download data
  if (!dir.exists("./data-GADM")) dir.create("./data-GADM")

  ## load raster data
  country <-
    raster::getData("GADM",
                    country = country,
                    level = 3,
                    path = './data-GADM')

  ## filter the location
  district <- country[country$NAME_2 %in% district, ]

  ## rename to name
  names(district)[which(names(district) == "VARNAME_3")] <- "name"

  # Match polygon ID

  rownames(district@data) <-
    map_chr(seq_len(nrow(district@data)), ~ district@polygons[[.x]]@ID)


  ## convert to json map
  geojson_map <- geojsonio::geojson_list(district)

  ## show the choosen town
  chosen_region <-
    map_chr(
      seq_along(geojson_map$features),
      ~ pluck(geojson_map, "features", .x, "properties", "name")
    )

  ## return result
  list(map = geojson_map, region = chosen_region)

}
