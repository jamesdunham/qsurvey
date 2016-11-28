utils::globalVariables(c("choice", "choice_id"))

#' Get survey response choices
#'
#' Retrieve a table giving the response choices for each question in a survey.
#'
#' @param design_object A \code{\link{qualtrics_design-class}} object retrieved
#' from Qualtrics by \code{\link{design}}.
#' @return A table of response choices. 
#'
#' @seealso \code{\link{blocks}}, \code{\link{questions}}
#' @importFrom utils type.convert
#' @export
choices <- function(design_object) {

  assert_is_design(design_object)
  choice_tree <- lapply(design_object$questions, function(x) {
    lapply(x[["choices"]], function(l) {
      nulls_to_na(l)
    })
  })
  choice_tbl <- parse_choices(choice_tree)
  format_choices(choice_tbl)
  return(choice_tbl[])
}

parse_choices <- function(choice_tree) {
  # choice_tree is a list of lists: there is a list for each survey item, and
  # each of these lists contains a list for each available choice

  x <- data.table::rbindlist(lapply(choice_tree, unlist, recursive = FALSE),
    fill = TRUE, idcol = "question_id")
  # x is now a wide table with columns like 9.description, 9.choiceText...
  x <- data.table::melt(x,
    id.vars = "question_id",
    variable.name = "choice_id",
    na.rm = TRUE)
  # split e.g. 9.description into a choice_id number and key
  x[, c("choice_id", "key") := data.table::tstrsplit(x$choice_id, "\\.")]
  x <- data.table::dcast.data.table(x, question_id + choice_id ~ key, value.var = "value")
  # we want a numeric sort on choice id
  x[, choice_id := type.convert(choice_id)]
  return(x[])
}

format_choices <- function(tbl) {
  data.table::setkeyv(tbl, c("question_id", "choice_id"))
  data.table::setnames(tbl, c("choiceText", "description", "recode",
      "variableName"), c("choice_text", "choice_description", "choice_recode",
      "variableName"))
  data.table::setnames(tbl, names(tbl), uncamel(names(tbl)))
}

