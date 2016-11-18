# qualtrics_design is an S3 class implemented by design(), whose return value is
# a list with 'qualtrics_design' added to its class().
print.qualtrics_design = function(x) {
  for (nm in c("name", "id", "creationDate", "lastModifiedDate",
               "responseCounts", "questions", "blocks")) {
    assertthat::assert_that(assertthat::has_name(x, nm))
  }
  message('name:\t\t', x$name)
  message('id:\t\t', x$id)
  message("created:\t", lubridate::date(x$creationDate))
  message("modified:\t", lubridate::date(x$lastModifiedDate))
  message("responses:\t", x$responseCounts$auditable,
          ifelse(x[["isActive"]], " (active)", " (closed)"))
  message("questions:\t", length(x$questions))
  message("blocks:\t\t", length(x$blocks))
}

#' @import assertthat
assert_is_design = function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
}

assert_is_table = function(tbl) {
  assertthat::assert_that("data.frame" %in% class(tbl))
}

