#' Download a survey design
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
design = function(id, as = "parsed") {
  r = qget(action = paste0("surveys/", id), as = as)
  if (identical(as, "parsed")) {
    return(r$result)
  } else {
    return(r)
  }
}
