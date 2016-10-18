#' Get item response choices
#'
#' Request a table giving the response choices for each survey item.
#'
#' @inheritParams responses
#' @return A data.table of response choices
#' @export
choices = function(id) {
  design = design(id)
  choices = lapply(design$questions, function(x) {
    lapply(x[["choices"]], function(l) {
      parse_question_element(l)
    })
  })
  choices = parse_choices(choices)

}

parse_choices = function(choices) {
  x = data.table::rbindlist(lapply(choices, unlist, recursive = FALSE),
    fill = TRUE, idcol = "question")
  x = data.table::melt(x, id.vars = "question", variable.name = "choice")
  x[, c("choice", "key") := data.table::tstrsplit(x$choice, "\\.")]
  x = data.table::dcast.data.table(x, question + choice ~ key, value.var = "value")
  return(x[])
}
