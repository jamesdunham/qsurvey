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
survey_design = function(id, as = "parsed") {

  assert_is_design(design)
  ret = qget(action = paste0("surveys/", id), as = as)
  if (identical(as, "parsed")) {
    ret = ret$result
  }
  class(ret) <- c("qualtrics_design", class(ret))
  return(ret)
}
