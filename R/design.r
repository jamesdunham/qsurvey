#' Export a survey design
#'
#' @inheritParams responses
#'
#' @return A list representing the survey design
#' @export
design = function(id) {
  r = qget(endpoint = paste0("surveys/", id))
  return(r$result)
}
