#' Plot a survey flow
#'
#' \code{plot_flow} shows a survey's flow as a directed graph showing possible
#' pathways through the elements of the survey.
#'
#' @inheritParams choices
#' @return \code{plot_flow} returns a visNetwork object.
#'
#' @importFrom visNetwork visEdges visHierarchicalLayout visInteraction visNetwork 
#' @seealso \code{\link{edges}}, \code{\link{nodes}}, \code{\link{render_flow}}
#' @export
plot_flow <- function(design_object) {

  assert_is_design(design_object)
  edge_tbl <- edges(design_object)
  edge_tbl <- add_edge_colors(edge_tbl)

  node_tbl <- nodes(design_object)
  node_tbl <- add_node_colors(node_tbl)

  net <- visNetwork::visNetwork(node_tbl, edge_tbl)
  net <- visNetwork::visInteraction(net,
    dragNodes = FALSE,
    dragView = FALSE,
    zoomView = FALSE)
  net <- visNetwork::visEdges(net, arrows = "to")
  net <- visNetwork::visNodes(net, shape = "dot")
  net <- visNetwork::visHierarchicalLayout(net, direction = "LR", sortMethod =
    "directed")
  net
}

add_node_colors <- function(edge_tbl) {
  # When plotting, node color depends on node type

  edge_tbl[type %in% c("StartSurvey", "EndSurvey"), color := "#fef4ab"]
  edge_tbl[type == "Block", color := "#d9d9d9"]
  edge_tbl[type == "Branch", color := "#fc9272"]
  edge_tbl[type == "BlockRandomizer", color := "#fc9272"]
  edge_tbl[type == "EmbeddedData", color := "#a3c4cd"]
  edge_tbl[]
}

add_edge_colors <- function(edge_tbl) {
  # When plotting, edge color depends on edge type

  edge_tbl[type == "deterministic", color :=  "#000000"]
  edge_tbl[type %in% c("conditional", "random"), color :=  "orange"]
  edge_tbl[]
}
