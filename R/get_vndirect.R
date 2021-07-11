#' Get stock data from vndirect
#'
#' @param symbol the symbol of stock
#' @param start_date the start date
#' @param end_date the end_date
#' @export
#' @importFrom lubridate ymd


get_vndirect <- function(symbol, start_date = NULL, end_date = NULL) {

  if(is.null(start_date)) {start_date = lubridate::today() - 15} else start_date = lubridate::ymd(start_date)
  if(is.null(end_date )) {end_date = lubridate::today()} else end_date = lubridate::ymd(end_date)
  size <- as.double(end_date - start_date)

  url <- "https://finfo-api.vndirect.com.vn"
  path <- glue::glue("/v4/stock_prices?sort=date&q=code:{symbol}~date:gte:{start_date}~date:lte:{end_date}&size={size}&page=1")

  get_result <- httr::modify_url(url, path = path)  %>%
    httr::GET() %>%
    httr::content(as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON()

  get_result$data %>%
    dplyr::as_tibble() %>%
    dplyr::mutate(date = ymd(date)) %>%
    return()
}

