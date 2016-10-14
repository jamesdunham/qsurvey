#' Export a survey design
#'
#' @param survey_id The survey identifier as a string
#'
#' @return A list representing the survey design
#' @export
get_survey_design = function(survey_id = "SV_738wNt5GB4wrTaR") {
  r = get(endpoint = paste0("surveys/", survey_id))
  return(r$result)
}
