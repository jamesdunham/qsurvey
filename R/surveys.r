utils::globalVariables(c("choice", "last_modified"))

#' Download survey metadata
#'
#' Retrieve names, identifiers, and other metadata for all available surveys.
#' The result is sorted by the \code{last_modified} timestamp in descending
#' order.
#'
#' @inheritParams request
#' @return A data.table of survey metadata
#' @importFrom lubridate ymd_hms
#' @export
#' @examples
#' surveys()
surveys <- function(key = Sys.getenv("QUALTRICS_KEY"),
  subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN")) {

  assert_key_set(key)
  subdomain <- set_if_missing(subdomain)

  pages <- get_pages(build_api_url("surveys", subdomain), key)
  pages <- Reduce(c, pages)
  tbl <- data.table::rbindlist(pages)
  format_surveys(tbl)
  return(tbl[])
}

get_pages <- function(page_url, key) {
  # The result of a request to the surveys API can span multiple pages. Get the
  # first page of the result, and then request the next page of results, until
  # there are no more pages.
  res <- list()
  while (length(page_url)) {
    response <- request("GET", key = key, api_url = page_url)
    json <- httr::content(response, as = "parsed")$result
    if (length(json$nextPage)) {
      page_url <- json$nextPage
    } else {
      page_url <- NULL
    }
    res <- c(res, list(json$elements))
  }
  return(res)
}

format_surveys <- function(tbl) {
  data.table::setnames(tbl, names(tbl), uncamel(names(tbl)))
  data.table::setkeyv(tbl, "name")
  tbl[, last_modified := .(lubridate::ymd_hms(last_modified))]
  data.table::setorder(tbl, -last_modified)
}

