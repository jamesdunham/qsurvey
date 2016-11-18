#' Render a survey design with a Shiny app
#'
#' @inheritParams choices
#'
#' @return Invisibly returns the data.table underlying the Shiny UI.
#' @export
render_survey = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  shiny::runApp(appDir = system.file("app", package = "qsurvey"))
}


