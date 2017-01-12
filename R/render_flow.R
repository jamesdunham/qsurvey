utils::globalVariables(c(".", "id", "block_id", "question_order", "node_id", "question_id",
    "question_text"))

#' Render a survey design with a Shiny app
#'
#' The Shiny app renders a visualization of the survey flow: blocks, branching,
#' randomization, etc. On selection of a block, its questions are visible.
#' Selecting a question in turn shows its text.
#'
#' @inheritParams choices
#'
#' @return \code{render_flow} invisibly returns the table underlying the Shiny
#' UI.
#' @seealso \code{\link{plot_flow}} for a visNetwork plot, or
#' \code{\link{nodes}} and \code{\link{edges}} for node and edge data in tabular
#' form.
#' @export
#' @importFrom shiny shinyApp fluidPage fluidRow column renderText
#' @importFrom magrittr %>%
#' @importFrom DT datatable dataTableOutput
#' @examples
#' \dontrun{
#' svy_design <- design("SV_0VVlb9QwJ4bsBKZ")
#' render_flow(svy_design)
#' }
render_flow <- function(design_object) {
  assert_is_design(design_object)

  # node_tbl gives node IDs
  node_tbl <- nodes(design_object)[, .(id, block_id)]
  data.table::setnames(node_tbl, c("id"), c("node_id"))

  q_tbl <- questions(design_object)

  block_tbl <- blocks(design_object, elements = TRUE)

  # add block IDs to the questions table
  ui_tbl <- merge(q_tbl, block_tbl, all.x = TRUE, all.y = FALSE, by = "question_id")

  # add node ids to the resulting table of block-questions
  ui_tbl <- merge(ui_tbl, node_tbl, all.x = TRUE, all.y = FALSE, by = "block_id")
  data.table::setkey(ui_tbl, question_order)

  shiny::shinyApp(
    ui = shiny::fluidPage(
      title = design_object$name,
      visNetwork::visNetworkOutput("network"),
      shiny::hr(),
      shiny::fluidRow(
        shiny::column(5, shiny::wellPanel(DT::dataTableOutput("tbl"))),
        shiny::column(6, shiny::htmlOutput("q_text"), offset = 1)
        )
      ),
  server <- function(input, output) {
    output$network <- visNetwork::renderVisNetwork(
      visNetwork::visHierarchicalLayout(plot_flow(design_object),
        direction = "LR",
        sortMethod = "directed") %>%
      visNetwork::visOptions(highlightNearest = FALSE) %>%
      visNetwork::visEvents(
        click = "function(_nodes){
        Shiny.onInputChange('click', _nodes.nodes[0]);
        ;}"
        )
      )

    output$tbl <- DT::renderDataTable(
      DT::datatable(
        ui_tbl[node_id == input$click][, .(export_name, question_id)],
        filter = "none",
        selection = "single",
        class = c("compact", "row-border", "stripe"),
        escape = TRUE,
        extensions = "Scroller",
        style = "bootstrap",
        options = list(searching = FALSE,
          paging = FALSE,
          ordering = FALSE)
        )
      )

    output$q_text <- shiny::renderText(
      ui_tbl[node_id == input$click][input$tbl_rows_selected, question_text]
      )
  })
}

