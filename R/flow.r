utils::globalVariables(c("edges", "br_subset", "edge_type", "edge_color", "name",
  "node", "parent_id", "width", "from", "node_color", "node_shape"))

#' Represent survey flows as node or edge tables
#'
#' @inheritParams choices
#' @aliases nodes
#' @export
edges = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  edge_tbl = search_flow(design$flow)
  edge_tbl = add_edge_types(edge_tbl)
  edge_tbl[, c("node_type", "label", "parent_id") := NULL, with = FALSE]
  data.table::setnames(edge_tbl, c("id", "edge_type"), c("to", "type"))
  data.table::setcolorder(edge_tbl, c("from", setdiff(names(edge_tbl), "from")))
  edge_tbl[]
}

#' @rdname edges
#' @export
nodes = function(design, ids = FALSE) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  node_tbl = search_flow(design$flow)
  data.table::setnames(node_tbl, c("node_type"), c("type"))
  node_tbl[, c("from") := NULL, with = FALSE]

  # the parent_id of level-1 nodes is 0; create a node with id 0 to represent
  # the start of the survey, though no sucha type exists in the Qualtrics API
  # node_tbl = data.table::rbindlist(list(data.frame(id = 0, type = "StartSurvey"),
    # node_tbl), fill = TRUE)

  # add descriptive labels for blocks
  block_tbl = blocks(design)
  node_tbl = merge(node_tbl, block_tbl, all.x = TRUE, all.y = FALSE,
    by.x = "label", by.y = "id")
  # use descriptions instead of BL_xx ids in block labels
  if (isTRUE(ids)) {
    node_tbl[type == "Block", block_id := label]
  }
  node_tbl[type == "Block", label := description]
  node_tbl[, description := NULL]
  data.table::setcolorder(node_tbl, union(c("id", "parent_id", "type",
    "label"), names(node_tbl)))

  node_tbl[type == "StartSurvey", label := "Start"]
  node_tbl[type == "EndSurvey", label := "End"]
  node_tbl[type == "EmbeddedData", label := "Set Data"]
  # finally use types in place of missing labels
  node_tbl[is.na(label), label := type]

  node_tbl[]
}

search_flow = function(f) {
  nodes = f[sapply(f, is.list)]
  edges = list(
    "id" = numeric(),
    "parent_id" = numeric(),
    "node_type" = character(),
    "label" = character()
  )
  n = 0
  parent_n = 0
  while (length(nodes)) {
    # n gives the id of the current node
    n = n + 1
    parent_n = ifelse(length(names(nodes[1])) && names(nodes[1]) != "",
      as.numeric(names(nodes[1])), parent_n)
    node_label = NA
    node_flow = NA
    # nodes is a FIFO queue
    node_type = nodes[[1]]$type
    if (node_type == "Block") {
      node_label = nodes[[1]]$id
      nodes[1] = NULL
    } else if (node_type %in% c("Branch", "BlockRandomizer")) {
      node_flow = nodes[[1]]$flow
      nodes = c(nodes, setNames(node_flow, rep(n, length(node_flow))))
      if (node_type == "BlockRandomizer") {
        node_label = paste0("Randomize: ",
          nodes[[1]]$randomizationOptions$randomSubset,
          " of ", length(node_flow),
          ifelse(nodes[[1]]$randomizationOptions$evenPresentation,
            " (evenly)", ""))
      }
      nodes[1] = NULL
    } else {
      nodes[1] = NULL
    }
    edges = data.table::rbindlist(list(
      edges,
      data.frame(
        "id" = n,
        "parent_id" = parent_n,
        "node_type" = node_type,
        "label" = node_label,
        stringsAsFactors = FALSE
      )),
      fill = TRUE
    )
  }
  edges = order_siblings(edges)
  edges[]
}

order_siblings = function(edge_tbl) {
  not_randomizers = unique(edge_tbl[node_type != "BlockRandomizer", id])
  edge_tbl[parent_id %in% c(0, not_randomizers), from := data.table::shift(id),
    by = "parent_id"]
  edge_tbl[is.na(from), from := parent_id]
  edge_tbl[]
}

add_edge_types = function(edge_tbl) {
  is_branch = unique(edge_tbl[node_type == "Branch", id])
  edge_tbl[parent_id %in% is_branch, `:=`(edge_type = "conditional")]
  is_randomizer = unique(edge_tbl[node_type == "BlockRandomizer", id])
  edge_tbl[parent_id %in% is_randomizer, `:=`(edge_type = "random")]
  edge_tbl[is.na(edge_type), `:=`(edge_type = "deterministic")]
  edge_tbl[]
}

add_node_shapes = function(edge_tbl) {
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
  edge_tbl[type %in% c("StartSurvey", "EndSurvey"), color := "#fef4ab"]
  edge_tbl[type == "Block", color := "#d9d9d9"]
  edge_tbl[type == "Branch", color := "#fc9272"]
  edge_tbl[type == "BlockRandomizer", color := "#fc9272"]
  edge_tbl[type == "EmbeddedData", color := "#a3c4cd"]
  edge_tbl[]
}

add_edge_colors = function(edge_tbl) {
  edge_tbl[type == "deterministic", color :=  "#000000"]
  edge_tbl[type %in% c("conditional", "random"), color :=  "orange"]
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
