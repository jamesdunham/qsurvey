#' Download export names for survey response fields
#'
#' Retrieve the descriptive export names (e.g., \code{favorability}) associated
#' with survey question identifiers (e.g., \code{QID1}).
#'
#' In some cases, there is more than one export name associated with a given
#' survey question identifier. Multiple-choice, multiple-answer questions have a
#' unique export name for each choice, but only one question identifier.
#'
#' @inheritParams responses
#' @return A two-column data.table giving \code{id} and \code{export_name}
#'   pairs.
#' @export
export_names = function(id) {
  sd = design(id)
  map = lapply(sd$exportColumnMap, `[[`, "question")
  ret = data.table::data.table("id" = unlist(map, recursive = FALSE),
    "export_name" = names(map), key = "name")
  return(ret[])
}
