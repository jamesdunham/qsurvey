#' Get export names for survey response fields
#'
#' Retrieve the descriptive export names (e.g., \code{favorability}) associated
#' with question ids (e.g., \code{QID1}).
#'
#' In some cases, there is more than one export name associated with a given
#' survey question identifier. Multiple-choice, multiple-answer questions have a
#' unique export name for each choice, but only one question identifier.
#'
#' @inheritParams choices
#' @return A two-column data.table giving \code{id} and \code{export_name}
#'   pairs.
#' @export
#' @examples
#' \dontrun{
#' design = survey_design("SV_cuxfjYWRTB30ouh")
#' export_names(design)
#' }
export_names = function(design) {

  assert_is_design(design)
  map = lapply(design$exportColumnMap, `[[`, "question")
  ret = data.table::data.table("id" = unlist(map, recursive = FALSE),
    "export_name" = names(map), key = "export_name")
  return(ret[])
}
