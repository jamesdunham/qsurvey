#' Render a survey design with a Shiny app
#'
#' The Shiny app renders a visualization of the survey flow: blocks, branching,
#' randomization, etc. On selection of a block, its questions are visible.
#' Selecting a question in turn shows its text. An example is available online
#' through shinyapps.io (TODO).
#'
#' @inheritParams choices
#'
#' @return \code{render_survey} invisibly returns the table underlying the Shiny
#' UI.
#' @export
render_survey = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  shiny::runApp(appDir = system.file("app", package = "qsurvey"))
}


