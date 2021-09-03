#' Geojson data map of Vietnam
#'
#'(Hoang Sa and Truong Sa are not included)
#' @examples
#' # To use this geojson map with echart4r package
#' library(echarts4r)
#' library(magrittr)
#' data.frame(province = 'Ha Tinh', value = 1) %>%
#' e_chart(province) %>%
#' e_map_register('vn', vntown) %>%
#' e_map(value, map = 'vn') %>%
#' e_visual_map(value)

"small_vnjson"
