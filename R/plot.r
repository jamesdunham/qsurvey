#' Represent a survey design as a graph
#'
#' \code{plot_flow} renders a survey's design as a directed graph showing
#' possible pathways through the elements of the survey.
#'
#' @inheritParams choices
#' @return \code{plot_flow} returns a visNetwork object.
#'
#' @import visNetwork
#' @aliases edges
#' @seealso \code{nodes} and \code{edges} for node and edge data in tabular
#'   form.
#' @export
plot_flow = function(design) {

  assertthat::assert_that("qualtrics_design" %in% class(design))
  edge_tbl = edges(design)
  edge_tbl = add_edge_colors(edge_tbl)

  node_tbl = nodes(design)
  node_tbl = add_node_colors(node_tbl)

  net = visNetwork::visNetwork(node_tbl, edge_tbl)
  net = visNetwork::visInteraction(net,
    dragNodes = FALSE,
    dragView = FALSE,
    zoomView = FALSE)
  net = visNetwork::visEdges(net, arrows = "to")
  net = visNetwork::visNodes(net, shape = "dot")
  net = visNetwork::visHierarchicalLayout(net, direction = "LR", sortMethod = "directed")
  net
}

add_node_shapes = function(edge_tbl) {
  # When plotting, node shape depends on node type

  edge_tbl[type == "EmbeddedData", shape := "dot"]
  edge_tbl[type == "BlockRandomizer", shape := "dot"]
  edge_tbl[type == "Branch", shape := "dot"]
  edge_tbl[type == "Block", shape := "dot"]
  # StartSurvey isn't a flow element type in the Qualtrics API, but is used in
  # qsurvey to represent the start of the survey
  edge_tbl[type %in% c("StartSurvey", "EndSurvey"), shape := "dot"]
  edge_tbl[is.na(shape), shape := "dot"]
  edge_tbl[]
}

add_node_colors = function(edge_tbl) {
  # When plotting, node color depends on node type

  edge_tbl[type %in% c("StartSurvey", "EndSurvey"), color := "#fef4ab"]
  edge_tbl[type == "Block", color := "#d9d9d9"]
  edge_tbl[type == "Branch", color := "#fc9272"]
  edge_tbl[type == "BlockRandomizer", color := "#fc9272"]
  edge_tbl[type == "EmbeddedData", color := "#a3c4cd"]
  edge_tbl[]
}

add_edge_colors = function(edge_tbl) {
  # When plotting, edge color depends on edge type

  edge_tbl[type == "deterministic", color :=  "#000000"]
  edge_tbl[type %in% c("conditional", "random"), color :=  "orange"]
  edge_tbl[]
}
