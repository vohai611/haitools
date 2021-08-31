#' Remove accent ingeneral
#'
#' Wrap around stringi
#' @param str String or vector of string you want to remove accent
#'
#' @return String vector
#'
#' @examples str_remove_accent('tôi muốn ăn cơm')
#'
#' @export

str_remove_accent <- function(str) {
  stringi::stri_trans_general(str, id = "Latin - ASCII")
}
