#' Download survey responses
#'
#' Retrieve the responses to a survey.
#'
#' \code{responses} requests that Qualtrics prepare a zipfile for download; once
#' it is ready, the archive is downloaded to a location given by
#' \code{\link[base]{tempfile}} and unzipped; its JSON contents read and parsed;
#' and the temporary files deleted.
#'
#' By default, descriptive question labels and choice descriptions (e.g.,
#' \code{favorability} and \code{strongly approve}) are requested instead of
#' question ids and choice codes (e.g., \code{QID1} and {5}). This is controlled
#' by argument \code{use_labels}.
#'
#' Other parameters that affect the format of the survey responses are
#' available. For example, passing \code{seenUnansweredRecode = "99"} in the
#' call to \code{responses} will show \code{"99"} as the response to unanswered
#' questions instead of \code{NA}. See the
#' \href{https://api.qualtrics.com/docs/json}{Qualtrics documentation} for the
#' details of these parameters. The parameters that cannot be changed via
#' \code{...} are \code{format}, \code{surveyId}, and \code{useLabels}, the last
#' of which is exposed as argument \code{use_labels}.
#'
#' @param id A Qualtrics survey identifier.
#' @param use_labels Use question labels and choice descriptions (default),
#'   instead of question and identifiers.
#' @param verbose Print progress.
#' @param ... Additional parameters for the \code{responseexports} API.
#'
#' @return A data.table of survey responses.
#' @seealso Retrieve a survey's \code{\link{questions}} or question
#'   \code{\link{choices}}.
#' @importFrom utils unzip txtProgressBar setTxtProgressBar
#' @importFrom jsonlite fromJSON
#' @export
responses = function(id, use_labels = TRUE, verbose = TRUE, ...) {
  r = qpost(
    action = "responseexports",
    body = list(
      format = "json",
      surveyId = id,
      useLabels = use_labels,
      ...
    )
  )
  export_id = r$result$id
  export_progress = 0
  if (isTRUE(verbose))  {
    message("Qualtrics is preparing responses for download...")
    pb = utils::txtProgressBar(max = 100, style = 3)
  }
  while (export_progress < 100) {
    r_export = qget(action = paste0("responseexports/", export_id))
    if (isTRUE(verbose))  {
      export_progress = r_export$result$percentComplete
      utils::setTxtProgressBar(pb, export_progress)
    }
  }
  if (isTRUE(verbose))  {
    close(pb)
    message("Downloading...")
  }
  # we get the survey responses as a zip-formatted file
  file_action = sub("https://az1.qualtrics.com/API/v3/", "",
    r_export$result$file, fixed = TRUE)
  bin = qget(action = file_action, as = "raw")
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
