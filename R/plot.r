#' Represent a survey design as a graph
#'
#' \code{plot_flow} and \code{edges} represent a survey's design as a directed
#' graph that shows possible paths through the elements of the survey.
#'
#' @inheritParams choices
#' @return \code{plot_flow} invisibly returns a DiagrammeR \code{dgr_graph}
#'   object. As a side effect, it renders the graph. \code{edges} returns a
#'   data.table of graph edges.
#'
#' @import visNetwork
#' @aliases edges
#' @export
plot_flow = function(design) {
  edge_tbl = edges(design)
  edge_tbl = add_edge_colors(edge_tbl)

  node_tbl = nodes(design)
  node_tbl = add_node_colors(node_tbl)

  net = visNetwork::visNetwork(node_tbl, edge_tbl)
  net = visNetwork::visInteraction(net, dragNodes = FALSE, dragView = FALSE, zoomView = FALSE)
  net = visNetwork::visEdges(net, arrows = "to")
  net = visNetwork::visNodes(net, shape = "dot")
  # net = visNetwork::visLegend(net, useGroups = FALSE, addEdges =
      # data.frame(label = c("deterministic", "conditional"), color = c("black", "orange")),
    # position = "right", main = "Edges")
  visNetwork::visHierarchicalLayout(net, direction = "LR", sortMethod = "directed")

  invisible(net)
}
