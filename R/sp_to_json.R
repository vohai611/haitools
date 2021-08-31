#' Transform sp to json
#'
#' Get json map for echart4r from sp data download from GADM (raster)
#'
#' @param sp sp object
#'
#' @param scope the scope of map data: town or district. \cr
#' Eample of town: Ha Noi, Ha Tinh. \cr
#' Example of district: Vinh, Hong Linh, Nghi Xuan
#' @return a json map ready to feed echarts4r::e_map_register()
#' @export
#'

sp_to_json <- function(sp = NULL, scope = NULL) {
  if ( is.null(scope)) {stop('scope must not NULL')}
  if ( !scope %in% c('town', 'district')) {stop('scope must be town or district')}
  if (scope == 'town') { names(sp)[which(names(sp) == "VARNAME_1")] <- 'name'}
  if (scope == 'district' ) {names(sp)[which(names(sp) == "VARNAME_2")] <- 'name'}

  # convert
  geojson_map <- geojsonio::geojson_list(sp)
  return(geojson_map)
  }


