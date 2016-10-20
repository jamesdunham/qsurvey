utils::globalVariables(c("export_label", "question"))

#' Get question names, labels, and text
#'
#' Retrieve the names, labels, and text of a given survey's questions.
#'
#' @inheritParams responses
#' @param text Retrieve question text (default), or don't
#'
#' @return A data.table of question names, labels, and (optionally) text
#' @export
questions = function(id, export_labels = TRUE, text = TRUE) {
  design = design(id)
  elements = "questionLabel"
  if (isTRUE(text)) {
    elements = c(elements, "questionText")
  }
  questions = lapply(design$questions, function(x) {
    parse_question_element(x[elements])
  })
  questions = data.table::rbindlist(questions, fill = TRUE, idcol = "question")
  if (isTRUE(export_labels)) {
    col_map = data.table::rbindlist(design$exportColumnMap, idcol = "export_label",
      fill = TRUE)[, .(export_label, question)]
    col_map = unique(col_map, by = "question")
    questions = merge(questions,
      col_map,
      all.x = TRUE,
      all.y = FALSE,
      by = "question")
  }
  return(questions[])
}

parse_question_element = function(l) {
  # Missing elements will be NULL in json but must be NA in data.table output
  lapply(l, function(x) {
    x = ifelse(is.null(x), NA, x)
    # Also drop HTML tags from question text
    gsub("(<[^>]*>)", "", x)
  })
}
