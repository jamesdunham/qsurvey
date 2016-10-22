#' Download survey metadata
#'
#' Retrieve names, identifiers, and other metadata for all available surveys.
#' The result is sorted by the \code{lastModified} timestamp in descending
#' order.
#'
#' @param ... Further arguments to \code{\link{request}}.
#'
#' @return A data.table of survey metadata
#' @importFrom lubridate ymd_hms
#' @export
surveys = function(...) {
  surveys = get_pages("surveys", ...)
  surveys = Reduce(c, surveys)
  tbl = data.table::rbindlist(surveys)
  data.table::setkeyv(tbl, "name")
  tbl[, lastModified := .(lubridate::ymd_hms(lastModified))]
  data.table::setorder(tbl, -lastModified)
  return(tbl[])
}

get_pages = function(page, ...) {
  # The result of a request to the surveys API can span multiple pages. Get the
  # first page of the result, and then request the next page of results, until
  # there are no more pages.
  res = list()
  while (length(page)) {
  parsed = qget(action = page, ...)
    if (length(parsed$result$nextPage)) {
      page = paste0(page, "?", sub(".*\\?", "", parsed$result$nextPage))
    } else {
      page = NULL
    }
    res = c(res, list(parsed$result$elements))
    cat(".")
  }
  return(res)
}
