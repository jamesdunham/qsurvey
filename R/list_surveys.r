#' List surveys
#'
#' @return A data.table of survey metadata
#' @export
list_surveys = function() {
  surveys = list()
  page = "surveys"
  # could excerpt this
  while (length(page)) {
    parsed = qget(endpoint = page, as = "parsed")
    if (length(parsed$result$nextPage)) {
      page = paste0("surveys?", sub(".*\\?", "", parsed$result$nextPage))
    } else {
      page = NULL
    }
    surveys = c(surveys, list(parsed$result$elements))
    cat(".")
  }
  # could also excerpt this
  surveys = Reduce(c, surveys)
  tbl = data.table::rbindlist(surveys)
  data.table::setkeyv(tbl, "name")
  return(tbl[])
}
