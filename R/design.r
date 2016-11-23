#' Download a survey's design
#'
#' Retrieve a representation of the elements in a given survey.
#'
#' @inheritParams responses
#' @inheritParams request
#'
#' @return By default, a list representing the survey design; see \code{as}.
#' @seealso Download a survey's \code{\link{responses}},
#'   \code{\link{questions}}, or question \code{\link{choices}}.
#' @export
#' @examples
#' \dontrun{
#' svy_design = design("SV_cuxfjYWRTB30ouh")
#' print(svy_design)
#' }
design = function(id, key = Sys.getenv("QUALTRICS_KEY")) {

  assertthat::assert_that(assertthat::is.string(id))
  req = qget(action = paste0("surveys/", id), key = key)
  ret = req$result
  class(ret) <- c("qualtrics_design", class(ret))
  return(ret)
}
