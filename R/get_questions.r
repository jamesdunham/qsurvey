#' Title
#'
#' @param id
#' @param text
#'
#' @return
#' @export
questions = function(id, text = TRUE) {
  design = get_survey_design(id)
  elements = "questionLabel"
  if (isTRUE(text)) {
    elements = c(elements, "questionText")
  }
  questions = lapply(design$questions, function(x) {
    parse_question_element(x[elements])
  })
  questions = data.table::rbindlist(questions, fill = TRUE, idcol = "question")
  return(questions)
}

parse_question_element = function(l) {
  lapply(l, function(x) {
    x = ifelse(is.null(x), NA, x)
    gsub("(<[^>]*>)", "", x)
  })
}
