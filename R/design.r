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
#' 
#' # set the API key from .api_key file
#' key_from_file()
#'
#' # id should be a valid survey ID
#' design = survey_design("SV_cuxfjYWRTB30ouh")
#' print(design)
#' }
survey_design = function(id) {

  assertthat::assert_that(assertthat::is.string(id))
  req = qget(action = paste0("surveys/", id))
  ret = req$result
  class(ret) <- c("qualtrics_design", class(ret))
  return(ret)
}
