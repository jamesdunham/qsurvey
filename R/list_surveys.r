#' List surveys
#'
#' Request a table giving survey names, identifiers, and other metadata.
#'
#' @return A data.table of survey metadata
#' @export
surveys = function() {
  surveys = get_pages("surveys")
  surveys = Reduce(c, surveys)
  tbl = data.table::rbindlist(surveys)
  data.table::setkeyv(tbl, "name")
  return(tbl[])
}

get_pages = function(page) {
  # Get the first page of a result, and then request all subsequent pages of
  # results
  res = list()
  while (length(page)) {
    parsed = qget(endpoint = page)
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
