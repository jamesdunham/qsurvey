utils::globalVariables(c("edges"))

#' Get survey flow
#'
#' @inheritParams responses
#'
#' @return An edge matrix
#' @export
flow = function(f) {
  edges = matrix(NA, ncol =  4, nrow = length(unlist(f)),
    dimnames = list(c(), c("parent", "id", "type", "block_id")))
  i = 0
  uid = 0
  walk_flow = function(parent, increment = 1) {
    parent_id = uid
    for (child in parent) {
      uid <<- uid + 1
      i <<- i + 1
      edges[i, c("parent", "id")] <<- c(parent_id, uid)
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
        } else if  (child$type == "BlockRandomizer") {
          walk_flow(child$flow, 0)
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
plot_flow = function(res) {
  edges = as.matrix(res[, .(parent, id)][, lapply(.SD, as.numeric)])
  v_labels = rbind(list("id" = 0L, type = "Start"),
    res[, .(id, type = paste(res$type,
      replace(res$block_id, is.na(res$block_id), "")))])
  g = igraph::graph_from_data_frame(edges[, c("parent", "id")])
  igraph::plot.igraph(g, edge.arrow.size = .1, layout = layout_as_tree(g),
    vertex.label = setNames(v_labels$type, v_labels$id),
    vertex.color = NA,
    vertex.shape = "none")
}
