#' Export survey responses
#'
#' @param id A Qualtrics survey identifier
#' @param labels Whether to use question labels and answer codes
#'
#' @return A data.table of survey responses
#' @importFrom utils unzip
#' @export
get_responses = function(id, labels = TRUE) {
  r = qpost(endpoint = "responseexports", body = list(format = "json",
    surveyId = id, useLabels = labels))
  export_id = r$result$id
  export_progress = 0
  while (export_progress < 100) {
    r_export = qget(endpoint = paste0("responseexports/", export_id))
    export_progress = r_export$result$percentComplete
    cat(export_progress, "... ")
  }
  # we get the survey responses as a zip-formatted file
  bin = qget(url = r_export$result$file, as = "raw")
  # write it to disk so we can unzip it
  temp_name = tempfile()
  writeBin(bin, temp_name)
  f_unzip = utils::unzip(temp_name, exdir = tempdir())
  json = jsonlite::fromJSON(f_unzip)
  # clean up files
  file.remove(temp_name)
  file.remove(f_unzip)
  # f_json is a list whose sole element is the data.frame of responses
  tbl = json[[1]]
  data.table::setDT(tbl)
  return(tbl[])
}
