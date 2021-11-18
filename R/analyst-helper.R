#' Indicate top high, low of numeric vector
#'
#' Return vector of 1,-1,0 indicate top high, low of input vector
#' 1 for top high, -1 for top low, 0 for the others
#' This function work on conjunction with geom_col(), to show for example top n high and lowest point
#' of some value
#'
#' @param x input vector
#' @param n number of top value each size
#'
#' @return numeric vecotr of 0, -1, and 1
#'
#' @export

top_hilo = function(x, n = 10) {
  y = sort(x)
  top = utils::head(y, n)
  bot = utils::tail(y, n)
  z = rep(0L, length(x))
  z[which(x %in% top)] = 1L
  z[which(x %in% bot)] = -1L
  z
}


#' Recode vector using multiple pattern/ replacement
#' @param x character vector input
#' @param pattern vector of pattern to replace
#' @param replace vector of value to replace the corresponding pattern above

#' @return character vector
#' @examples
#' data = sample(letters, 20, replace = TRUE)
#' recode_with(data, c('a','b','c'), c(1,2,3))
#' @export


recode_with = function(x, pattern, replace){
  stopifnot(length(pattern) == length(replace))

  y = replace
  names(y) = pattern

  changed = y[x]

  # preserve the remaining value (no match value)
  changed[is.na(changed)] = x[is.na(changed)]
  unname(changed)
}
