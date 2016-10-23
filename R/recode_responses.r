#' Recode survey responses
#'
#' \code{values_to_labels} recodes survey responses that contain choice values
#' or ids (like \code{"5"}) using descriptive labels (like \code{"strongly
#' approve"}). \code{labels_to_values} does the reverse.
#'
#' @inheritParams drop_sensitive
#' @inheritParams responses
#' @return The data.frame with recoded responses.
#' @export
values_to_labels = function(tbl, id) {
  map = merge(
    choices(id),
    unique(export_names(id), by = "name"),
    all.x = TRUE,
    all.y = FALSE,
    by.x = "question",
    by.y = "name"
  )
  # FIXME: unique() gives only the first export name for each question
  head(map)
  if (!data.table::is.data.table(tbl)) {
    tbl = data.table::setDT(tbl)
  }
  # TODO: recode values
  return(tbl[])
}

#' @rdname values_to_labels
#' @aliases labels_to_values
#' @export
labels_to_values = function(tbl, id) {

}

# https://stackoverflow.com/questions/32875581/best-practice-to-recode-multiple-subsets
# # Recode choice values
# # Recode choice labels
# en = export_names(id)
# en
#
# id = "SV_4ScmWFqU9mFban3"
# ch = choices(id)
# head(ch)
# ch[question == "QID135"]
#
# sr_nolabel = responses(id, labels = FALSE)
# sr_label = responses(id)
# names(sr_nolabel)
# names(sr_label)
