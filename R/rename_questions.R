#' Rename response table columns
#'
#' \code{ids_to_names} takes a table of responses and renames the columns with
#' question identifier names (e.g. \code{QID2}) using question names (e.g.,
#' \code{approval}). \code{names_to_ids} does the reverse.
#'
#' @inheritParams drop_sensitive
#' @inheritParams choices
#'
#' @return The table with renamed columns.
#' @aliases names_to_ids
#' @seealso \code{\link{drop_meta}}, \code{\link{drop_sensitive}}, 
#' \code{\link{keep_questions}} 
#' @export
ids_to_names <- function(tbl, design_object) {
  en <- export_names(design_object)
  data.table::setDT(tbl)
  data.table::setnames(tbl, en$question_id, en$export_name)
  return(tbl[])
}

#' @rdname ids_to_names
#' @export
names_to_ids <- function(tbl, design_object) {
  en <- export_names(design_object)
  data.table::setDT(tbl)
  data.table::setnames(tbl, en$export_name, en$question_id)
  return(tbl[])
}
