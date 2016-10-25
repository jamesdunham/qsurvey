utils::globalVariables(c("edges"))

search_flow = function(f) {
  nodes = f[sapply(f, is.list)]
  edges = list("node" = numeric(),  "parent" = numeric(),
    "name" = character(),
    "subset" = numeric())
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
  edges = add_edge_types(edges)
  edges = add_edge_colors(edges)
  edges = add_node_types(edges)
  edges = add_node_colors(edges)
  edges = add_node_shapes(edges)
  edges[]
}

order_siblings = function(edges) {
  not_randomizers = unique(edges[name != "BlockRandomizer", node])
  edges[parent %in% c(0, not_randomizers), previous := data.table::shift(node),
    by = "parent"]
  edges[is.na(previous), previous := parent]
  edges[]
}

add_edge_types = function(edges) {
  is_branch = unique(edges[name == "Branch", node])
  edges[parent %in% is_branch, `:=`(edge_type = "conditional")]

  is_randomizer = unique(edges[name == "BlockRandomizer", node])
  edges[parent %in% is_randomizer, `:=`(edge_type = "random")]

  edges[is.na(edge_type), `:=`(edge_type = "deterministic")]
  edges[]
}

add_node_types = function(edges) {
  edges[grepl("^Block BL_", name), node_type := "Block"]
  edges[grepl("^EmbeddedData$", name), node_type := "Data"]
  edges[grepl("^WebService$", name), node_type := "Web Svc."]
  edges[grepl("^Authenticator$", name), node_type := "Auth."]
  edges[grepl("^TableOfContents$", name), node_type := "TOC"]
  edges[grepl("^BlockRandomizer$", name), node_type := "Rand."]
  edges[grepl("^EndSurvey$", name), node_type := "End"]
  edges[is.na(node_type), node_type := name]
  edges[]
}

add_node_shapes = function(edges) {
  edges[node_type == "Block", node_shape := "square"]
  edges[node_type == "Block", width := 1.1]
  edges[node_type == "End", node_shape := "circle"]
  edges[is.na(node_shape), node_shape := "circle"]
  edges[]
}

add_node_colors = function(edges) {
  edges[node_type == "End", node_color := "#fef4ab"]
  edges[node_type == "Block", node_color := "#d9d9d9"]
  edges[node_type == "Branch", node_color := "#fc9272"]
  edges[node_type == "Rand.", node_color := "#fc9272"]
  edges[node_type == "Data", node_color := "#a3c4cd"]
  edges[]
}

add_edge_colors = function(edges) {
  edges[edge_type == "deterministic", edge_color :=  "#000000"]
  edges[edge_type %in% c("conditional", "orange"), edge_color :=  "orange"]
  edges[]
}

add_block_descriptions = function(edges, design) {
  edges[grepl("^Block ", name), node_type := unlist(lapply(name, function(x) {
    stringr::str_wrap(design$blocks[[sub("^Block ", "", x)]]$description,
      width = 15)
  }
  ))]
  edges[grepl("^BlockRandomizer$", name), node_type :=
      paste0(node_type, "\n", br_subset)]
  edges[]
}

#' Plot flow
#'
#' @import igraph
#' @export
plot_flow = function(edges, design) {

  edges = add_block_descriptions(edges, design)
  nodes = create_nodes(
    nodes = c(0, edges$node),
    label = c("Start", edges$node_type),
    type = c("Start", edges$node_type),
    shape = c("circle", edges$node_shape),
    width = c(0.4, edges$width),
    fillcolor = c("#fef4ab", edges$node_color))
  edges = create_edges(
    from = edges$previous,
    to = edges$node,
    color = edges$edge_color)

  create_graph(
    nodes_df = nodes,
    edges_df = edges,
    graph_attrs = "layout = dot; rankdir = LR") %>%
    set_node_attrs("fontcolor", "black") %>%
    render_graph()
}
# res = search_flow(sd$flow)
# plot_flow(res, sd)
