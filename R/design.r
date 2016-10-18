#' Export a survey design
#'
#' Retrieve a JSON representation of a survey's design, as a list.
#'
#' @inheritParams responses
#'
#' @return A list representing the survey design
#' @export
design = function(id) {
  r = qget(endpoint = paste0("surveys/", id))
  return(r$result)
}
