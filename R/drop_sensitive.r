#' Drop columns from survey responses
#'
#' \code{drop_sensitive} drops the columns that give approximate location, IP
#' address, contact name, and contact email from a table of survey responses.
#' \code{drop_meta} also drops other standard columns that don't represent
#' question responses. \code{keep_questions} is most strict, keeping only the
#' columns for survey questions; it drops columns with embedded data, for
#' example.
#'
#' The following metadata columns are dropped by \code{drop_sensitive}, if they
#' exist in the table:
#' \itemize{
#' \item LocationLatitude
#' \item LocationLongitude
#' \item LocationAccuracy
#' \item IPAddress
#' \item RecipientLastName
#' \item RecipientFirstName
#' \item RecipientEmail
#' }
#'
#' \code{drop_meta} drops those columns and any of the following:
#' \itemize{
#' \item ExternalDataReference
#' \item EndDate
#' \item Finished
#' \item ResponseID
#' \item ResponseSet
#' \item StartDate
#' \item Status
#' }
#'
#' @param tbl A data.frame of survey responses.
#'
#' @return The data.frame without the dropped columns.
#' @aliases drop_meta keep_questions
#' @export
drop_sensitive = function(tbl) {

  assert_is_table(tbl)
  cols = c("LocationLatitude",
    "LocationLongitude",
    "LocationAccuracy",
    "IPAddress",
    "RecipientLastName",
    "RecipientFirstName",
    "RecipientEmail")
  cols = intersect(cols, names(tbl))

  tbl = drop_cols(tbl, cols)
  return(tbl[])
}


#' @rdname drop_sensitive
#' @export
drop_meta = function(tbl) {

  assert_is_table(tbl)
  tbl = drop_sensitive(tbl)
  cols = c(
    "EndDate",
    "ExternalDataReference",
    "Finished",
    "ResponseID",
    "ResponseSet",
    "StartDate",
    "Status")
  cols = intersect(cols, names(tbl))

  tbl = drop_cols(tbl, cols)
  return(tbl)
}


#' @rdname drop_sensitive
#' @export
keep_questions = function(tbl, design) {

  assert_is_table(tbl)
  assert_is_design(design)

  cols = setdiff(names(tbl), export_names(design)[, export_name])
  tbl = drop_cols(tbl, cols)
  return(tbl[])
}


drop_cols = function(tbl, drop_cols) {
  ## Given a data.frame tbl, drop columns given by the character drop_cols

  assert_is_table(tbl)
  assertthat::assert_that(is.character(drop_cols))

  data.table::setDT(tbl)
  for (col in drop_cols) {
    tbl[, col := NULL, with = FALSE]
  }
  tbl[]
}
