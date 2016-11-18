#' Recode survey responses
#'
#' \code{values_to_labels} recodes survey responses that contain choice ids or
#' recodes (like \code{"5"}) to descriptive labels (like \code{"strongly
#' approve"}). \code{labels_to_values} does the reverse, replacing descriptive
#' labels with choice ids or recodes.
#'
#' @inheritParams drop_sensitive
#' @inheritParams responses
#' @return The data.frame with recoded responses.
#' @export
values_to_labels = function(tbl, design, keep = FALSE) {

  assertthat::assert_that(is.data.frame(tbl))
  assertthat::assert_that("qualtrics_design" %in% class(design))
  # TODO: give choice of ids or recodes
  ret = map_values_and_labels(tbl, design, keep, direction = "VL")
  return(ret[])
}

#' @rdname values_to_labels
#' @aliases labels_to_values
#' @export
labels_to_values = function(tbl, design, keep = FALSE) {

  assertthat::assert_that(is.data.frame(tbl))
  assertthat::assert_that("qualtrics_design" %in% class(design))
  ret = map_values_and_labels(tbl, design, keep, direction = "LV")
  return(ret[])
}


map_values_and_labels = function(tbl, design, keep, direction = c("VL", "LV")) {
  # Translate values to labels or vice-versa.

  map = merge(
    choices(design),
    unique(export_names(design), by = "id"),
    all.x = TRUE,
    all.y = FALSE,
    by.x = "question",
    by.y = "id"
  )
  if (direction == "VL") {
    stem = "_label"
    by_var = "recode"
  } else if (direction == "LV") {
    stem = "_value"
    by_var = "description"
  } else {
    stop("direction can be 'VL' or 'LV'")
  }
  # FIXME: unique() gives only the first export name for each question
  tbl = data.table::setDT(tbl)
  n = nrow(tbl)
  if (!any(c(map$export_name, map$question) %in% names(tbl))) {
    stop("couldn't find expected columns in tbl")
  }
  for (colname in intersect(union(map$export_name, map$question), names(tbl))) {
    # FIXME: colname might be a value in question instead of export_name
    crosswalk_tbl = map[export_name == colname, .(recode, description)]
    data.table::setnames(crosswalk_tbl, c(by_var, paste0(colname, stem)))
    # TODO: check for duplicates in crosswalk_tbl
    tbl = merge(
      tbl,
      crosswalk_tbl,
      by.x = colname,
      by.y = by_var,
      all.x = TRUE,
      all.y = FALSE
    )
    if (!isTRUE(keep)) {
      # drop the existing column and replace it with the joined column
      tbl[, colname := NULL, with = FALSE]
      data.table::setnames(tbl, paste0(colname, stem), colname)
    }
  }
  stopifnot(identical(n, nrow(tbl)))
  # TODO: check success of join
  return(tbl[])
}
