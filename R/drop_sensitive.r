#' Drop sensitive columns from survey responses
#'
#' Drop the columns that give approximate location, IP address, contact name,
#' and contact email from a table of survey responses.
#'
#' The following metadata columns are dropped, if they exist in the table:
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
#' @param tbl A data.frame of survey responses.
#'
#' @return The data.frame without the sensitive columns.
#' @export
drop_sensitive = function(tbl) {
  assertthat::assert_that(is.data.frame(tbl))
  drop_cols =  c("LocationLatitude",
    "LocationLongitude",
    "LocationAccuracy",
    "IPAddress",
    "RecipientLastName",
    "RecipientFirstName",
    "RecipientEmail")
  drop_cols = intersect(drop_cols, names(tbl))
  data.table::setDT(tbl)
  for (col in drop_cols) {
      tbl[, col := NULL, with = FALSE]
  }
  return(tbl[])
}
