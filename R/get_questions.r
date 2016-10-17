#' Get question names, labels, and text
#'
#' Given a survey ID, retrieve the names, labels, and text of the survey's
#' questions.
#'
#' @param id surveyID
#' @param text Whether to include question text in the result
#'
#' @return A data.table of question names, labels, and (optionally) text
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
