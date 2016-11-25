#' Get survey response counts
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
#' @inheritParams choices
#'
#' @return A named integer vector giving response counts.
#' @export
response_counts <- function(design_object) {
  assert_is_design(design_object)
  unlist(design_object$responseCounts)
}
