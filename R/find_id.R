utils::globalVariables(c("lastModified"))

#' Find survey ids by searching survey names
#'
#' \code{find_id} searches for survey names that match argument \code{pattern}.
#' All arguments but \code{first} are passed to \code{\link[base]{grepl}} for
#' pattern matching.
#'
#' \code{find_id} retrieves the names and ids of all available surveys (using
#' \code{\link{surveys}}), and then uses \code{\link[base]{grepl}} to search the
#' names for matches.
#'
#' For \code{first = TRUE} (the default), only the id of the first matching name
#' (if any) is returned. Matches are sorted by \code{lastModified} timestamp
#' (descending), so \code{first = TRUE} gives the id of the matching survey most
#' recently modified.
#'
#' @param first Whether to return only the first match (default) or all matches.
#'   See Details.
#' @param pattern Character string containing a regular expression (or character
#'   string for \code{fixed = TRUE}).
#' @inheritParams base::grepl
#' @return A named character vector giving the id(s) of matching surveys, or an
#' empty character vector if there are no matches.
#'
#' @seealso \code{\link{surveys}}
#' @include surveys.R
#' @importFrom stats setNames
#' @export
#' @examples
#' \dontrun{
#' find_id("demographics")
#' }
find_id <- function(pattern,
  first = TRUE,
  ignore.case = TRUE,
  perl = TRUE,
  fixed = FALSE) {

  svy_tbl <- surveys()
  is_match <- grepl(pattern,
    svy_tbl$name,
    ignore.case = ignore.case,
    perl = perl,
    fixed = fixed)
  match_tbl <- svy_tbl[is_match]
  if (nrow(match_tbl) == 0) {
    ret <- character()
  } else if (isTRUE(first)) {
    ret <- setNames(match_tbl$id[1], match_tbl$name[1])
  } else {
    ret <- setNames(match_tbl$id, match_tbl$name)
  }
  return(ret)
}
