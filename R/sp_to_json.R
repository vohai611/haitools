#' Transform sp to json
#'
#' Get json map for echart4r from sp data download from GADM (raster)
#'
#' @param sp Sp object. Might be downloaded from raster:getdata()
#'
#' @param scope The scope of map data: town or district. \cr
#' Eample of town: Ha Noi, Ha Tinh. \cr
#' Example of district: Vinh, Hong Linh, Nghi Xuan
#' @param std_name Should use standard name  or not \cr
#' For example, "Hà Tĩnh" is non-standard name, while "Ha Tinh" is standard name
#' @return A json map ready to feed echarts4r::e_map_register()
#' @export
#'

sp_to_json <- function(sp = NULL,
                       scope = NULL,
                       std_name = TRUE) {
  # check argument
  if (is.null(scope)) {
    stop('scope must not NULL')
  }
  if (!scope %in% c('town', 'district')) {
    stop('scope must be town or district')
  }
  if (!is.logical(std_name)) {
    stop('std_name must be logical')
  }

  if (std_name) {
    if (scope == 'town') {
      names(sp)[which(names(sp) == "VARNAME_1")] <- 'name'
    }
    if (scope == 'district') {
      names(sp)[which(names(sp) == "VARNAME_2")] <- 'name'
    }
  } else {
    if (scope == 'town') {
      names(sp)[which(names(sp) == "NAME_1")] <- 'name'
    }
    if (scope == 'district') {
      names(sp)[which(names(sp) == "NAME_2")] <- 'name'
    }
  }


  # convert
  geojson_map <- geojsonio::geojson_list(sp)
  return(geojson_map)
}
