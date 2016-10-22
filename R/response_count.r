#' Download survey response counts
#'
#' Response counts are given in three categories defined by the Qualtrics API:
#' auditable, generated, and deleted. See Details.
#'
#' Categories:
#' \itemize{
#' \item \code{auditable}: typical responses
#' \item \code{generated}: responses created using the Qualtrics control panel's
#' "Test Survey" tool
#' \item \code{deleted}: responses removed using the Qualtrics control panel's
#' "Delete Data" tool
#' }
#'
#' @inheritParams responses
#'
#' @return A list giving response counts.
#' @export
response_count = function(id) {
  d = design(id)
  d$responseCounts
}
