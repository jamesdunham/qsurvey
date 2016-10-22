utils::globalVariables(c("lastModified"))

#' Find survey IDs by searching survey names
#'
#' \code{find_id} searches for survey names that match argument \code{pattern}.
#'
#' \code{find_id} retrieves the names and IDs of all available surveys (using
#' \code{\link{surveys}}), and then uses \code{\link[base]{grepl}} to search the
#' names for matches.
#'
#' For \code{first = TRUE} (the default), only the id of the first matching name
#' (if any) will be returned. Matches are sorted by \code{lastModified}
#' timestamp (descending), so \code{first = TRUE} gives the id of the matching
#' survey most recently modified.
#'
#' All arguments but \code{first} are passed to \code{\link[base]{grepl}} for
#' pattern matching.
#'
#' @param first Whether to return only the first match (default) or all matches.
#'   See Details.
#' @param pattern Character string containing a regular expression (or character
#'   string for \code{fixed = TRUE}).
#' @inheritParams base::grepl
#' @return A named character vector.
#'
#' @importFrom stats setNames
#' @export
find_id = function(pattern,
  first = TRUE,
  ignore.case = TRUE,
  perl = TRUE,
  fixed = FALSE) {
  svy_tbl = surveys()
  is_match = grepl(pattern,
    svy_tbl$name,
    ignore.case = ignore.case,
    perl = perl,
    fixed = fixed)
  matches = svy_tbl[is_match]
  if (nrow(matches) == 0) {
    ret = NA
  } else if (isTRUE(first)) {
    ret = setNames(matches$id[1], matches$name[1])
  } else {
    ret = setNames(matches$id, matches$name)
  }
  return(ret)
}
