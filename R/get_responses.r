#' Export survey responses
#'
#' @param id A Qualtrics survey identifier
#' @param labels Whether to use question labels and answer codes
#'
#' @return A data.table of survey responses
#' @export
get_responses = function(id = "SV_738wNt5GB4wrTaR", labels = TRUE) {
  r = post(endpoint = "responseexports", body = list(format = "json", surveyId = id,
    useLabels = labels))
  export_id = r$result$id
  export_progress = 0
  while (export_progress < 100) {
    r_export = get(endpoint = paste0("responseexports/", export_id))
    export_progress = r_export$result$percentComplete
    cat(export_progress, "... ")
  }
  f_raw = get(url = httr::content(r_export)$result$file, as = "raw")
  # check writeable
  writeBin(f_raw, "f.zip")
  f_json = jsonlite::fromJSON("Output.json")
  # clean up files
  # check structure
  tbl = f_json[[1]]
  data.table::setDT(tbl)
  return(tbl[])
}
