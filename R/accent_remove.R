#' Remove Vietnamese accent
#' @importFrom magrittr %>%
#' @param str String or vector of string you want to remove accent
#'
#' @return String vector
#'
#' @examples accent_remove('tôi muốn ăn cơm')
#'
#'
#' @export

accent_remove<-function(str){
  str %>%
    stringr::str_replace_all(pattern ="Ð","D" ) %>%
    stringr::str_to_lower() %>%
    stringr::str_replace_all(pattern ="à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ|à","a" ) %>%
    stringr::str_replace_all(pattern ="è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ","e" ) %>%
    stringr::str_replace_all(pattern ="ì|í|ị|ỉ|ĩ","i" ) %>%
    stringr::str_replace_all(pattern ="ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ|ọ","o" ) %>%
    stringr::str_replace_all(pattern ="ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ","u" ) %>%
    stringr::str_replace_all(pattern ="ỳ|ý|ỵ|ỷ|ỹ","y" ) %>%
    stringr::str_replace_all(pattern ="đ","d" ) %>%
    stringr::str_to_lower()
}
