# survey_server = function(input, output) {
#   output$network = visNetwork::renderVisNetwork(
#     visNetwork::visHierarchicalLayout(plot_flow(design),
#       direction = "LR",
#       sortMethod = "directed") %>%
#       visNetwork::visOptions(highlightNearest = FALSE) %>%
#       visNetwork::visEvents(
#         click = "function(nodes){
#                  Shiny.onInputChange('click', nodes.nodes[0]);
#                  ;}"
#       )
#   )
#
#   output$tbl = DT::renderDataTable(
#     DT::datatable(
#       ui_tbl[node_id == input$click][, .(export_label, question_id)],
#       filter = "none",
#       selection = "single",
#       class = c("compact", "row-border", "stripe"),
#       escape = TRUE,
#       extensions = "Scroller",
#       style = "bootstrap",
#       options = list(searching = FALSE,
#         paging = FALSE,
#         ordering = FALSE)
#     )
#   )
#
#   output$q_text = shiny::renderText(
#     ui_tbl[node_id == input$click][input$tbl_rows_selected, questionText]
#   )
#
# }

#' Render a survey design with a Shiny app
#'
#' @param choices Foo
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

  # node_tbl gives node IDs
  node_tbl = nodes(design, ids = TRUE)[, .(id, block_id)]
  data.table::setnames(node_tbl, c("id"), c("node_id"))

  q_tbl = questions(design, html = TRUE)
  data.table::setnames(q_tbl, c("question"), c("question_id"))

  block_tbl = blocks(design, elements = TRUE)
  data.table::setnames(block_tbl, c("id"), c("block_id"))

  # add block IDs to the questions table
  ui_tbl = merge(q_tbl, block_tbl, all.x = TRUE, all.y = FALSE, by = "question_id")

  # ui_tbl[questionText == "Timing", element_type == "Timing"]

  # add node ids to the resulting table of block-questions
  ui_tbl = merge(ui_tbl, node_tbl, all.x = TRUE, all.y = FALSE, by = "block_id")
  data.table::setkey(ui_tbl, q_order)

  ui = shiny::fluidPage(
    title = design$name,
    visNetwork::visNetworkOutput("network"),
    shiny::hr(),
    shiny::fluidRow(
      shiny::column(5, shiny::wellPanel(DT::dataTableOutput("tbl"))),
      shiny::column(6, shiny::htmlOutput("q_text"), offset = 1)
    )
  )

  shiny::runApp(list(ui = ui, server = survey_server))
# shiny::shinyApp(ui = ui, server = server)

  invisible(ui_tbl)
}
