#' Rename response table columns
#'
#' \code{ids_to_names} takes a table of responses and renames the columns with
#' question identifier names (e.g. \code{QID2}) using question names (e.g.,
#' \code{approval}). \code{names_to_ids} does the reverse.
#'
#' @inheritParams drop_sensitive
#' @inheritParams choices
#'
#' @return The data.frame with renamed columns.
#' @aliases names_to_ids
#' @export
ids_to_names = function(tbl, design) {
  en = export_names(design)
  data.table::setDT(tbl)
  data.tabel::setnames(tbl, en$id, en$export_name)
  return(tbl[])
}

#' @rdname ids_to_names
#' @export
names_to_ids = function(tbl, design) {
  en = export_names(design)
  data.table::setDT(tbl)
  data.tabel::setnames(tbl, en$export_name, en$id)
  return(tbl[])
}
