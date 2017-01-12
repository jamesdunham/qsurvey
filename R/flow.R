utils::globalVariables(c("edges", "br_subset", "edge_type", "edge_color",
    "name", "node", "parent_id", "width", "from", "node_color", "node_shape",
    "type", "color", "node_type", "id", "block_id", "label", "block_description"))

#' Represent survey flows as node or edge tables
#'
#' A survey flow can usefully be considered a directed graph. \code{edges} shows
#' its edge pairs, and \code{nodes} gives its nodes.
#'
#' @inheritParams choices
#' @aliases nodes
#' @seealso \code{\link{plot_flow}}, \code{\link{render_flow}}
#' @export
edges <- function(design_object) {

  assert_is_design(design_object)

  edge_tbl <- search_flow(design_object$flow)
  edge_tbl <- add_edge_types(edge_tbl)
  edge_tbl[, c("node_type", "label", "parent_id") := NULL]
  data.table::setnames(edge_tbl, c("id", "edge_type"), c("to", "type"))
  data.table::setcolorder(edge_tbl, c("from", setdiff(names(edge_tbl), "from")))
  edge_tbl[]
}

#' @rdname edges
#' @export
nodes <- function(design_object) {

  assert_is_design(design_object)

  node_tbl <- search_flow(design_object$flow)
  data.table::setnames(node_tbl, c("node_type"), c("type"))
  node_tbl[, c("from") := NULL]

  # add descriptive labels for blocks
  block_tbl <- blocks(design_object)
  node_tbl <- merge(node_tbl, block_tbl, all.x = TRUE, all.y = FALSE,
    by.x = "label", by.y = "block_id")
  # use descriptions instead of BL_xx ids in block labels
  node_tbl[type == "Block", block_id := label]
  node_tbl[type == "Block", label := block_description]
  node_tbl[, block_description := NULL]
  data.table::setcolorder(node_tbl, union(c("id", "parent_id", "type",
    "label"), names(node_tbl)))

  node_tbl[type == "StartSurvey", label := "Start"]
  node_tbl[type == "EndSurvey", label := "End"]
  node_tbl[type == "EmbeddedData", label := "Set Data"]
  # use node types in place of missing labels
  node_tbl[is.na(label), label := type]

  node_tbl[]
}


search_flow <- function(f) {
  # Conduct a breadth-first search of a survey flow

  nodes <- f[sapply(f, is.list)]
  edges <- list(
    "id" = numeric(),
    "parent_id" = numeric(),
    "node_type" = character(),
    "label" = character()
  )
  n <- 0
  parent_n <- 0
  while (length(nodes)) {
    # n gives the id of the current node
    n <- n + 1
    parent_n <- ifelse(length(names(nodes[1])) && names(nodes[1]) != "",
      as.numeric(names(nodes[1])), parent_n)
    node_label <- NA
    node_flow <- NA
    # nodes is a FIFO queue
    node_type <- nodes[[1]]$type
    if (node_type == "Block") {
      node_label <- nodes[[1]]$id
      nodes[1] <- NULL
    } else if (node_type %in% c("Branch", "BlockRandomizer")) {
      node_flow <- nodes[[1]]$flow
      nodes <- c(nodes, setNames(node_flow, rep(n, length(node_flow))))
      if (node_type == "BlockRandomizer") {
        node_label <- paste0("Randomize: ",
          nodes[[1]]$randomizationOptions$randomSubset,
          " of ", length(node_flow),
          ifelse(nodes[[1]]$randomizationOptions$evenPresentation,
            " (evenly)", ""))
      }
      nodes[1] <- NULL
    } else {
      nodes[1] <- NULL
    }
    edges <- data.table::rbindlist(list(
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
  edges <- order_siblings(edges)
  edges[]
}


order_siblings <- function(edge_tbl) {
  # Consecutive elements of the same generation always appear to a respondent in
  # the same order (unless their parent is a BlockRandomizer). Edges should
  # connect the parent and the first sibling, and then each consecutive sibling.

  not_randomizers <- unique(edge_tbl[node_type != "BlockRandomizer", id])
  edge_tbl[parent_id %in% c(0, not_randomizers), from := data.table::shift(id),
    by = "parent_id"]
  edge_tbl[is.na(from), from := parent_id]
  edge_tbl[]
}


add_edge_types <- function(edge_tbl) {
  # Edge type (conditional, random, or deterministic) depends on parent node
  # type

  is_branch <- unique(edge_tbl[node_type == "Branch", id])
  edge_tbl[parent_id %in% is_branch, `:=`(edge_type = "conditional")]
  is_randomizer <- unique(edge_tbl[node_type == "BlockRandomizer", id])
  edge_tbl[parent_id %in% is_randomizer, `:=`(edge_type = "random")]
  edge_tbl[is.na(edge_type), `:=`(edge_type = "deterministic")]
  edge_tbl[]
}
