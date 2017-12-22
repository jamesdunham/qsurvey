#' Download survey responses
#'
#' Retrieve the responses to a survey.
#'
#' Implementation: \code{responses} requests that Qualtrics prepare a zipfile
#' for download; once it is ready, the archive is downloaded to a location given
#' by \code{\link[base]{tempfile}} and unzipped; its JSON contents read and
#' parsed; and the temporary files deleted.
#'
#' By default, descriptive question labels and choice descriptions are requested
#' instead of question ids and choice codes. This is controlled by argument
#' \code{use_labels}.
#'
#' Other \href{https://api.qualtrics.com/docs/json}{documented} Qualtrics API
#' parameters that affect the format of survey responses are available. For
#' example, passing \code{seenUnansweredRecode = "99"} in the call to
#' \code{responses} will show \code{"99"} as the response to unanswered
#' questions instead of \code{NA}, the default. The parameters that cannot be
#' changed via \code{...} are \code{surveyId} (exposed as argument \code{id}),
#' \code{useLabels} (exposed as argument \code{use_labels}), and \code{format},
#' (which must be \code{json}).
#'
#' @param id A Qualtrics survey identifier.
#' @param use_labels Use question labels and choice descriptions (default),
#'   instead of question and identifiers.
#' @param verbose Print progress.
#' @param ... Additional parameters for the \code{responseexports} API.
#' @inheritParams request
#'
#' @return A table of survey responses.
#' @seealso \code{\link{design}}
#' @importFrom utils unzip txtProgressBar setTxtProgressBar
#' @importFrom jsonlite fromJSON
#' @export
responses <- function(id,
                     use_labels = TRUE,
                     verbose = FALSE,
                     key = Sys.getenv("QUALTRICS_KEY"),
                     subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN"),
                     ...) {

  # Adapted from the Python example:
  # https://api.qualtrics.com/docs/response-exports

  # requests() handles checking of key and subdomain arguments
  assertthat::assert_that(assertthat::is.string(id))
  assertthat::assert_that(assertthat::is.flag(use_labels))
  assertthat::assert_that(assertthat::is.flag(verbose))
  query_list <- list(...)
  if (length(query_list)) {
    assertthat::assert_that(is.list(query_list))
    assertthat::assert_that(identical(length(names(query_list)),
        length(query_list)))
    assertthat::assert_that(!any(c("surveyId", "format", "useLabels") %in%
        names(query_list)))
  }

  r <- request("POST",
    api_url = build_api_url("responseexports", subdomain),
    body = c(
      list(
        format = "json",
        surveyId = id,
        useLabels = use_labels
      ),
      query_list
    ),
    verbose = verbose,
    key = key,
    subdomain = subdomain
  )
  export_id <- httr::content(r, as = "parsed", encoding = "UTF-8")$result$id
  export_progress <- 0
  if (isTRUE(verbose))  {
    message("Qualtrics is preparing responses for download...")
    pb <- utils::txtProgressBar(max = 100, style = 3)
  }
  while (export_progress < 100) {
    r_export <- qget(action = paste0("responseexports/", export_id),
        key = key, subdomain = subdomain, verbose = verbose)
    export_progress <- r_export$result$percentComplete
    if (isTRUE(verbose))  {
      utils::setTxtProgressBar(pb, export_progress)
    }
  }
  if (isTRUE(verbose))  {
    close(pb)
    message("Downloading...")
  }

  # The API provides survey responses as a zip-formatted file whose absolute URL
  # is given by r_export$result$file once available. 
  file_response <- request("GET", key = key, subdomain = subdomain, api_url =
    r_export$result$file, verbose = verbose)
  # write it to disk so we can unzip it
  temp_name <- tempfile()
  writeBin(httr::content(file_response, as = "raw", encoding = "UTF-8"),
    temp_name)
  f_unzip <- utils::unzip(temp_name, exdir = tempdir())
  json <- jsonlite::fromJSON(f_unzip)
  # json is a list whose sole element is the data.frame of responses
  tbl <- json[[1]]

  # clean up files
  file.remove(temp_name)
  file.remove(f_unzip)

  data.table::setDT(tbl)
  return(tbl[])
}
