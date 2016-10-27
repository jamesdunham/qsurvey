utils::globalVariables(c("edges", "br_subset", "edge_type", "edge_color", "name",
  "node", "parent", "width", "previous", "node_color", "node_shape"))

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
#' @import DiagrammeR
#' @aliases edges
#' @export
plot_flow = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  edge_tbl = search_flow(design$flow)
  edge_tbl = add_edge_types(edge_tbl)
  edge_tbl = add_edge_colors(edge_tbl)
  edge_tbl = add_node_types(edge_tbl)
  edge_tbl = add_node_colors(edge_tbl)
  edge_tbl = add_node_shapes(edge_tbl)
  edge_tbl = add_block_descriptions(edge_tbl, design)
  nodes = DiagrammeR::create_nodes(
    nodes = c(0, edge_tbl$node),
    label = c("Start", edge_tbl$node_type),
    type = c("Start", edge_tbl$node_type),
    shape = c("circle", edge_tbl$node_shape),
    width = c(0.4, edge_tbl$width),
    fillcolor = c("#fef4ab", edge_tbl$node_color))
  edge_tbl = DiagrammeR::create_edges(
    from = edge_tbl$previous,
    to = edge_tbl$node,
    color = edge_tbl$edge_color)

  graph = DiagrammeR::create_graph(
    nodes_df = nodes,
    edges_df = edge_tbl,
    graph_attrs = "layout = dot; rankdir = LR")
  graph = DiagrammeR::set_node_attrs(graph, "fontcolor", "black")
  DiagrammeR::render_graph(graph)
  invisible(graph)
}

#' @name plot_flow
#' @inheritParams plot_flow
#' @export
edges = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  edge_tbl = search_flow(design$flow)
  edge_tbl[]
}

search_flow = function(f) {
  nodes = f[sapply(f, is.list)]
  edges = list(
    "node" = numeric(),
    "parent" = numeric(),
    "name" = character(),
    "br_subset" = numeric()
  )
  n = 0
  parent_n = 0
  while (length(nodes)) {
    # n gives the id of the current node
    n = n + 1
    parent_n = ifelse(length(names(nodes[1])) && names(nodes[1]) != "",
      as.numeric(names(nodes[1])), parent_n)
    br_options = NULL
    # nodes is a FIFO queue
    node_type = nodes[[1]]$type
    if (node_type == "Block") {
      node_type = paste(node_type, nodes[[1]]$id)
      nodes[1] = NULL
    } else if (node_type %in% c("Branch", "BlockRandomizer")) {
      node_flow = nodes[[1]]$flow
      nodes = c(nodes, setNames(node_flow, rep(n, length(node_flow))))
      if (node_type == "BlockRandomizer") {
        br_options = list(
          nodes[[1]]$randomizationOptions$randomSubset,
          nodes[[1]]$randomizationOptions$evenPresentation
        )
      }
      nodes[1] = NULL
    } else {
      nodes[1] = NULL
    }
    edges = data.table::rbindlist(list(
      edges,
      data.frame(
        "node" = n,
        "parent" = parent_n,
        "name" = as.character(node_type),
        "br_subset" = ifelse(is.null(br_options), NA, br_options[[1]]),
        "br_presentation" = ifelse(is.null(br_options), NA, br_options[[2]]),
        stringsAsFactors = FALSE
      )),
      fill = TRUE
    )
    message(parent_n, " - ", n, " (", node_type, ")")
  }
  edges = order_siblings(edges)
  edges[]
}

order_siblings = function(edge_tbl) {
  not_randomizers = unique(edge_tbl[name != "BlockRandomizer", node])
  edge_tbl[parent %in% c(0, not_randomizers), previous := data.table::shift(node),
    by = "parent"]
  edge_tbl[is.na(previous), previous := parent]
  edge_tbl[]
}

add_edge_types = function(edge_tbl) {
  is_branch = unique(edge_tbl[name == "Branch", node])
  edge_tbl[parent %in% is_branch, `:=`(edge_type = "conditional")]
  is_randomizer = unique(edge_tbl[name == "BlockRandomizer", node])
  edge_tbl[parent %in% is_randomizer, `:=`(edge_type = "random")]
  edge_tbl[is.na(edge_type), `:=`(edge_type = "deterministic")]
  edge_tbl[]
}

add_node_types = function(edge_tbl) {
  edge_tbl[grepl("^Block BL_", name), node_type := "Block"]
  edge_tbl[grepl("^EmbeddedData$", name), node_type := "Data"]
  edge_tbl[grepl("^WebService$", name), node_type := "Web Svc."]
  edge_tbl[grepl("^Authenticator$", name), node_type := "Auth."]
  edge_tbl[grepl("^TableOfContents$", name), node_type := "TOC"]
  edge_tbl[grepl("^BlockRandomizer$", name), node_type := "Rand."]
  edge_tbl[grepl("^EndSurvey$", name), node_type := "End"]
  edge_tbl[is.na(node_type), node_type := name]
  edge_tbl[]
}

add_node_shapes = function(edge_tbl) {
  edge_tbl[node_type == "Block", node_shape := "square"]
  edge_tbl[node_type == "Block", width := 1.1]
  edge_tbl[node_type == "End", node_shape := "circle"]
  edge_tbl[is.na(node_shape), node_shape := "circle"]
  edge_tbl[]
}

add_node_colors = function(edge_tbl) {
  edge_tbl[node_type == "End", node_color := "#fef4ab"]
  edge_tbl[node_type == "Block", node_color := "#d9d9d9"]
  edge_tbl[node_type == "Branch", node_color := "#fc9272"]
  edge_tbl[node_type == "Rand.", node_color := "#fc9272"]
  edge_tbl[node_type == "Data", node_color := "#a3c4cd"]
  edge_tbl[]
}

add_edge_colors = function(edge_tbl) {
  edge_tbl[edge_type == "deterministic", edge_color :=  "#000000"]
  edge_tbl[edge_type %in% c("conditional", "orange"), edge_color :=  "orange"]
  edge_tbl[]
}

#' @importFrom stringr str_wrap
add_block_descriptions = function(edge_tbl, design) {
  edge_tbl[grepl("^Block ", name), node_type := unlist(lapply(name, function(x) {
    stringr::str_wrap(design$blocks[[sub("^Block ", "", x)]]$description,
      width = 15)
  }))]
  edge_tbl[grepl("^BlockRandomizer$", name), node_type :=
      paste0(node_type, "\n", br_subset)]
  edge_tbl[]
}
