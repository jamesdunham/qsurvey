utils::globalVariables(c("export_label", "question", "question_order"))

#' Get survey questions
#'
#' Retrieve identifiers and text for a given survey's questions.
#'
#' @inheritParams choices
#' @return \code{questions} returns a table of question identifiers and text.
#' @seealso \code{\link{blocks}}, \code{\link{choices}}
#' @export
questions <- function(design_object) {

  assert_is_design(design_object)

  tbl <- lapply(design_object$questions, function(x) {
    nulls_to_na(x["questionText"])
  })
  tbl <- data.table::rbindlist(tbl, fill = TRUE, idcol = "question_id")

  # the only indicator of question order in design_object$questions is the list
  # order (but this could be checked against their order of appearance in
  # design_object$blocks)
  tbl[, question_order := .I]

  # add export names
  tbl <- merge(tbl,
    export_names(design_object),
    all.x = TRUE,
    all.y = FALSE,
    by = "question_id")

  format_questions(tbl)
  return(tbl[])
}

nulls_to_na <- function(element) {
  # Missing elements will be NULL in json but must be NA in tabular output

  lapply(element, function(x) {
    ifelse(is.null(x), NA, x)
  })
}

format_questions <- function(tbl) {
  data.table::setkey(tbl, "question_order")
  data.table::setnames(tbl, names(tbl), uncamel(names(tbl)))
  set_first_cols(tbl,c("question_order", "question_id",
      "export_name", "question_text"))
}
