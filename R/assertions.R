assert_is_design <- function(design) {
  assertthat::assert_that("qualtrics_design" %in% class(design))
}

assert_is_table <- function(tbl) {
  assertthat::assert_that("data.frame" %in% class(tbl))
}

assert_key_set <- function(key) {
  # A key should be provided in the call to request() or set by the user and
  # retrieved by Sys.getenv(). If not, stop.

  assertthat::assert_that(assertthat::is.string(key))
  if (key == "") {
    stop("Qualtrics API key needed. Set the environment variable QUALTRICS_KEY.")
  } else {
    return(TRUE)
  }
}
