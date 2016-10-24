utils::globalVariables(c("edges"))

#' Download survey flow
#'
#' @inheritParams responses
#'
#' @return A data.table giving edges between flow elements, and their ids.
#' @export
flow = function(f) {
  edges = matrix(NA, ncol =  4, nrow = length(unlist(f)),
    dimnames = list(c(), c("parent", "id", "type", "block_id")))
  i = 0
  uid = 0
  walk_flow = function(parent, increment = 1, br_child_ids = NULL) {
    parent_id = uid
    for (child in parent) {
      uid <<- uid + 1
      i <<- i + 1
      # if (length(br_child_ids)) {
      #   i = seq.int(i, i + length(br_child_ids) - 1)
      #   edges[i, "parent"] <<- br_child_ids
      #   edges[i, "id"] <<- uid
      #   br_child_ids = NULL
      #   i = max(i)
      # } else {
        edges[i, c("parent", "id")] <<- c(parent_id, uid)
      # }
      if ("type" %in% names(child)) {
        edges[i, "type"] <<- child$type
        if (child$type == "Block") {
          if ("id" %in% names(child)) {
            edges[i, "block_id"] <<- child$id
          } else {
            edges[i, "block_id"] <<- "missing"
          }
        } else if (child$type == "Branch") {
          walk_flow(child$flow)
          parent_id = parent_id - increment
          # for (id in exit_ids) {
          #   i = i + 1
          #   edges[i, c("parent", "id")] <<- c(id, uid)
          # }
        } else if  (child$type == "BlockRandomizer") {
          # Note the id of this BR child; all its children will be parents of
          # the next child.
          # br_id = uid + 1
          walk_flow(child$flow, 0)
          # # Get the ids of all the BR's children
          # br_child_ids = edges[edges[, "parent"] == br_id, "id"]
        }
      }
      parent_id = parent_id + increment
      uid <<- uid
      i <<- i
    }
  }
  walk_flow(f)
  edges = as.data.frame(edges[!is.na(edges[, 1]), ], stringsAsFactors = FALSE)
  data.table::setDT(edges)
  numerics = c("id", "parent")
  edges[, c(numerics) := lapply(.SD, type.convert), .SDcols = numerics]
    edges
  return(edges[])
}

blocks = function(d) {
  # Extract from a design() list the block tree, as a list

  # d is the value of design(), which should have a child "flow"
  assertthat::assert_that(assertthat::has_name(d, "flow"))
  # d$flow has a child for each survey flow element
  blocks = lapply(d$flow, parse_flow_element)
  return(blocks)
}

parse_flow_element = function(x) {
  if (length(x["type"]) && x["type"] == "Block") {
    # the Block element has a chr child 'id'
    return(x[["id"]])
  } else if (length(x["type"]) && x["type"] %in% c("Branch", "BlockRandomizer")) {
    # the Branch and BlockRandomizer elements can have Block children; they
    # should be parsed recursively
    return(lapply(x$flow, parse_flow_element))
  } else {
    return(NULL)
  }
}
# BL_40K7sfJSwyeDWK1
# BL_0pOwMhRwKH3NaDj
# BL_5BxBZvhlFtqYuBD
# BL_6sdcvo3KXVh7neZ
# BL_5auEEcoifvMJ3sF
# unlist(blocks)
# b[!sapply(b, is.null)]

block_questions = function(d) {
  # Extract from a design() list the questions contained in each blocks

  # d is the value of design(), which should have a child "blocks"
  assertthat::assert_that(assertthat::has_name(d, "blocks"))
  # d$blocks has a child for each block, each of which is a list; each of these
  # in turn has a child for each question in the block (or page break, and possibly
  # other content types)
  blocks = lapply(d$blocks, function(x) {
    # for each block, flatten the list of block contents into a table that has
    # columns "type" and "questionId"
    block_tbl = data.table::rbindlist(x$elements, fill = TRUE)
    block_tbl[get("type") != "PageBreak"]
  })
  # block_tbl columns are expected to be consistent, so fill = FALSE
  tbl = data.table::rbindlist(blocks, idcol = "block")
  return(tbl[])
}

#' Plot flow
#'
#' @import igraph
#' @export
plot_flow = function(edges) {
g = igraph::graph_from_data_frame(
  as.matrix(edges[, .(previous, node)][, lapply(.SD, as.numeric)]),
  vertices = rbind(data.frame("node" = 0, "name" = "Start"),
    edges[, .("node" = as.numeric(node), name)]))
igraph::plot.igraph(
  g,
  edge.arrow.size = .25,
  layout = igraph::layout_as_tree(g),
  # vertex.label = NA,
  vertex.color = NA,
  vertex.shape = "none")
}

search_flow = function(f) {
  nodes = f[sapply(f, is.list)]
  edges = list("node" = numeric(),  "parent" = numeric(),
    name = character())
  n = 0
  parent_n = 0
  while (length(nodes)) {
    # n gives the id of the current node
    n = n + 1
    parent_n = ifelse(length(names(nodes[1])) && names(nodes[1]) != "",
      as.numeric(names(nodes[1])), parent_n)
    # nodes is a FIFO queue
    node_type = nodes[[1]]$type
    if (node_type == "Block") {
      node_type = paste(node_type, nodes[[1]]$id)
      nodes[1] = NULL
    } else if (node_type %in% c("Branch", "BlockRandomizer")) {
      node_flow = nodes[[1]]$flow
      nodes = c(nodes, setNames(node_flow, rep(n, length(node_flow))))
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
        stringsAsFactors = FALSE
      )),
      fill = TRUE
    )
    message(parent_n, " - ", n, " (", node_type, ")")
  }
  order_siblings(edges)
}

order_siblings = function(edges) {
  not_randomizers = unique(edges[name != "BlockRandomizer", node])
  edges[parent %in% c(0, not_randomizers), previous := data.table::shift(node),
    by = "parent"]
  edges[is.na(previous), previous := parent]
  edges[]
}

