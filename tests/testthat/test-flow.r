library(testthat)

test_that("flow() handles block; block", {
  test_flow = list(
    list(type = "Block"),
    list(type = "Block"))
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  res
  expect_equal(res$id, c(1, 2))
  expect_equal(res$parent, c(0, 1))
  expect_equal(res$type, c("Block", "Block"))
})

test_that("flow() handles WebService; block; branch -> block", {
  test_flow = list(
    list(type = "WebService"),
    list(id = "BL_1", type = "Block"),
    list(type = "Branch", flow = list(list(
      id = "BL_2", type = "Block"
    )))
  )
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  res
  expect_equal(res$id, c(1, 2, 3, 4))
  expect_equal(res$parent, c(0, 1, 2, 3))
  expect_equal(res$type, c("WebService", "Block", "Branch", "Block"))
  expect_equal(res$block_id, c(NA, "BL_1", NA, "BL_2"))
})

test_that("flow() handles branch->randomizer->blocks; block", {
  test_flow = list(
    list(type = "Branch",
      flow = list(
        list(type = "BlockRandomizer", flow = list(
          list(id = "BL_1", type = "Block"),
          list(id = "BL_2", type = "Block")
        ))
      )),
    list(id = "BL_3", type = "Block")
  )
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  res
  expect_equal(res$id, c(1:5, 5))
  expect_equal(res$parent, c(0, 1, 2, 3, 2, 3))
  expect_equal(res$type, c("Branch", "BlockRandomizer", rep("Block", 4)))
  expect_equal(res$block_id, c(NA, NA, "BL_1", "BL_2", "BL_3", "BL_3"))
})

# library(igraph)
# y[, prev := c(NA, id[-.N]), by = "parent_id"]
# y[!is.na(prev), seq := .(prev)]
# y[is.na(prev), seq := .(parent_id)]
# y[, rank := data.table::frank(parent_id, ties.method = "dense")]
# y
# l = as.matrix(y[, .(rank, id)][, lapply(.SD, as.numeric)])
# g = graph_from_data_frame(y[, .(seq, id)])
# plot(g, edge.arrow.size = .1, layout = layout_as_tree(g))

# library(qualtrics)
# id = "SV_2bDLL1k3csf1mlv"
# d = design(id)
# fl = d$flow


# v = rbind(list("id" = 0L, type = "root"), res[, .(id, type)])
# g = graph_from_data_frame(res[, .(parent, id),], vertices = v)
#
# plot(
#   g,
#   edge.arrow.size = .1,
#   layout = layout_as_tree(g),
#   vertex.label = setNames(v$type, v$id),
#   vertex.color = NA,
#   vertex.shape = "none"
# )
#
# tree <- list(1:6,b=list(a=20:23,b=28),c=c("a","b"))
# str(tree)
# index.leaves <- function(root) {
#   walk <- function(node,idx,acc) {
#     if(length(node)>1) {
#       r<-Map(function(child,i) walk(child,c(idx,i),acc),node,seq_along(node))
#       unlist(r,recursive=FALSE)
#     }
#     else {
#       list(c(acc,idx))
#     }
#   }
#   walk(root,NULL,c())
# }
# str(tree)
# str(index.leaves(tree))
#
# nametree2 <- function(X) {
#
#   rec <- function(X, prefix = NULL) {
#     if( length(X) == 1 ) return(prefix)
#     lapply(seq_along(X), function(i) rec(X[[i]], c(prefix,i)))
#   }
#
#   z <- rec(X)
#
#   # Convert nested list into a simple list
#   z2 <- rapply(z,length)
#   split(unlist(z),rep(seq_along(z2),z2))
# }
# str(tree)
# str(nametree2(tree))
#
#
