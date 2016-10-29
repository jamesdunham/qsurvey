#' Retrieve block ids, descriptions, and elements
#'
#' @inheritParams choices
#'
#' @return A data.table giving the \code{id} and \code{description} of each
#'   block.
#' @export
blocks = function(design, elements = FALSE) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
  block_list = lapply(design$blocks, function(x) {
    data.table::rbindlist(x[["elements"]], fill = TRUE)[,
      description := x[["description"]]][,
      randomization := paste(unlist(x[["randomization"]]), collapse = ", ")]
  })
  block_tbl =
    data.table::rbindlist(block_list, use.names = TRUE, fill = TRUE, idcol = "id")
  data.table::setnames(block_tbl, c("type", "questionId"), c("element_type", "question_id"))
  data.table::setcolorder(block_tbl, union(c("id", "description", "element_type", "question_id"),
    names(block_tbl)))
  if (!isTRUE(elements)) {
    block_tbl = unique(block_tbl, by = "id")[, .(id, description)]
  }
  block_tbl[]
}
