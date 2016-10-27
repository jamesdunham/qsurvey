utils::globalVariables(c("choice"))

#' Get survey response choices
#'
#' Retrieve a table giving the response choices for each question in a given
#' survey.
#'
#' @param design A \code{\link{qualtrics_design-class}} object.
#' @return A data.table of response choices
#'
#' @seealso Download a survey's \code{\link{questions}},
#'   \code{\link{responses}}, or \code{\link{design}}.
#' @importFrom utils type.convert
#' @export
choices = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  choices = lapply(design$questions, function(x) {
    lapply(x[["choices"]], function(l) {
      parse_question_element(l)
    })
  })
  choices = parse_choices(choices)
  return(choices[])
}

parse_choices = function(choices) {
  # choices is a list of lists: there is a list for each survey item, and each
  # of these lists contains a list for each available choice
  x = data.table::rbindlist(lapply(choices, unlist, recursive = FALSE),
    fill = TRUE, idcol = "question")
  # x is now a wide table with columns like 9.description, 9.choiceText...
  x = data.table::melt(x,
    id.vars = "question",
    variable.name = "choice",
    na.rm = TRUE)
  # split e.g. 9.description into a choice number and key
  x[, c("choice", "key") := data.table::tstrsplit(x$choice, "\\.")]
  x = data.table::dcast.data.table(x, question + choice ~ key, value.var = "value")
  # we want a numeric sort on choice number
  x[, choice := type.convert(choice)]
  data.table::setkeyv(x, c("question", "choice"))
  return(x[])
}
