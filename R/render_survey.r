
#' Render a survey design with a Shiny app
#'
#' @inheritParams choices
#'
#' @return Invisibly returns the data.table underlying the Shiny UI.
#' @export
render_survey = function(design) {
  # TODO:
  # * add header
  # * optionally suppress timers?

  # key_from_file()
  # id = find_id("test")
  # design = survey_design(id)

  shiny::runApp(appDir = system.file("app", package = "qsurvey"))

  # invisible(ui_tbl)
}


