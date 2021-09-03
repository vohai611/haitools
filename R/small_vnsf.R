#' Small sf data of Vietnam map
#'
#' Hoang Sa and Truong Sa are not included
#'
#' @examples
#' # This sf map data is easy to visualize with ggplot2
#' library(ggplot2)
#' library(magrittr)
#'
#' ggplot(small_vnsf, aes(geometry = geometry))+
#' geom_sf()+
#' coord_sf()
#'
"small_vnsf"
