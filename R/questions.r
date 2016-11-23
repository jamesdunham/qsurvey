utils::globalVariables(c(".", "export_label", "question"))

#' Get survey questions
#'
#' Retrieve the names, labels, and text of a given survey's questions.
#'
#' @inheritParams choices
#' @param labels Retrieve question labels (default), or don't.
#' @param text Retrieve question text (default), or don't.
#'
#' @return A data.table of question names, labels, and (optionally) text
#' @seealso Retrieve a survey's question \code{\link{choices}} or
#'   \code{\link{responses}}.
#' @export
questions = function(design, labels = TRUE, text = TRUE, html = FALSE) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  elements = "questionLabel"
  if (isTRUE(text)) {
    elements = c(elements, "questionText")
  }
  q_tbl = lapply(design$questions, function(x) {
    parse_question_element(x[elements], html)
  })
  q_tbl = data.table::rbindlist(q_tbl, fill = TRUE, idcol = "question_id")
  # the only indicator of question order in design$questions is the list order.
  # this could be checked against their order of appearance in design$blocks
  q_tbl[, q_order := .I]
  if (isTRUE(labels)) {
    col_map = data.table::rbindlist(design$exportColumnMap, idcol = "export_label",
      fill = TRUE)[, .(export_label, question)]
    col_map = unique(col_map, by = "question")
    q_tbl = merge(q_tbl,
      col_map,
      all.x = TRUE,
      all.y = FALSE,
      by.x = "question_id",
      by.y = "question")
  }
  data.table::setkey(q_tbl, "q_order")
  return(q_tbl[])
}

parse_question_element = function(l, html = FALSE) {
  # Missing elements will be NULL in json but must be NA in data.table output
  lapply(l, function(x) {
    x = ifelse(is.null(x), NA, x)
    # Also drop HTML tags from question text
    if (!isTRUE(html)) {
      return(gsub("(<[^>]*>)", "", x))
    } else {
      return(x)
    }
  })
}
