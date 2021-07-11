#' Get stock data from cafef.vn
#'
#' @param symbol the code of stock
#' @param start_date the start date
#' @param end_date the end date
#' @return a tibble contain all data of the stock in that period
#' @export
#' @importFrom magrittr %>%
#' @examples
#' get_cafeF('ACB', "1/1/2020", "1/2/2020")
#' @importFrom rlang .data
#' @import dplyr



get_cafeF <- function(symbol, start_date, end_date) {
  ngay <- NULL
  link <- "https://s.cafef.vn/Lich-su-giao-dich-VNG-1.chn"

  form <- rvest::read_html(link) %>%
    rvest::html_form()

  form <- form[[1]]

  result_row <-
    sum(!lubridate::wday(seq(lubridate::dmy(start_date), lubridate::dmy(end_date), by = "day")) %in% c(1, 7))
  total_page <- result_row %/% 20 + 1
  get_page <- function(symbol, start_date , end_date , page ) {

  request <-   httr::POST(
      link,
      body = list(
        `ctl00$ContentPlaceHolder1$scriptmanager` = "ctl00$ContentPlaceHolder1$ctl03$panelAjax|ctl00$ContentPlaceHolder1$ctl03$pager2",
        `ctl00$ContentPlaceHolder1$ctl03$txtKeyword` = symbol,
        `ctl00$ContentPlaceHolder1$ctl03$dpkTradeDate1$txtDatePicker` = start_date,
        `ctl00$ContentPlaceHolder1$ctl03$dpkTradeDate2$txtDatePicker` = end_date,
        `ctl00$UcFooter2$hdIP` = NULL,
        `__EVENTTARGET` =  "ctl00$ContentPlaceHolder1$ctl03$pager2",
        `__EVENTARGUMENT` = page,
        `__VIEWSTATE` = form$fields$`__VIEWSTATE`$value,
        `__VIEWSTATEGENERATOR` = form$fields$`__VIEWSTATEGENERATOR`$value,
        `__ASYNCPOST:` = "true"
      )
    )
  ## parse request to tibble
  x <- request %>%
      rvest::read_html() %>%
      rvest::html_table(header = TRUE)

  x[[2]] %>%
    janitor::clean_names() %>%
    slice(-1) %>%
    select(-contains("kl_dot"), - contains("thay_doi_percent")) %>%
    mutate(ngay = lubridate::dmy(ngay)) %>%
    mutate(across(-ngay, readr::parse_number))
  }

    future::plan(future::multisession, workers = 4)
   result <-  furrr::future_map_dfr(seq_len(total_page),
                          ~ get_page(symbol, start_date, end_date, .x),
                          .progress = TRUE)
   closeAllConnections()
   return(result)
}
