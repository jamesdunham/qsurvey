#' Get response counts for a survey
#'
#' Response counts are given by category. \code{generated} responses are those
#' created by the "Test Survey" tool. \code{deleted} responses were removed by
#' the "Delete Data" tool.
#'
#' @inheritParams responses
#'
#' @return A list giving response counts
#' @export
response_count = function(id) {
  d = design(id)
  d$responseCounts
}
