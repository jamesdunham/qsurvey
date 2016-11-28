#' Get export names for survey response fields
#'
#' Retrieve the descriptive export names associated with question ids (e.g.,
#' \code{QID1}).
#'
#' In some cases, there is more than one export name associated with a given
#' survey question identifier. Multiple-choice, multiple-answer questions have a
#' unique export name for each choice, but only one question identifier.
#'
#' @inheritParams choices
#' @return A two-column giving \code{question_id} and \code{export_name}
#'   pairs. See details.
#' @seealso \code{\link{questions}}
#' @export
export_names <- function(design_object) {

  assert_is_design(design_object)

  map <- lapply(design_object$exportColumnMap, `[[`, "question")
  ret <- data.table::data.table("question_id" = unlist(map, recursive = FALSE),
    "export_name" = names(map), key = "export_name")
  return(ret[])
}
