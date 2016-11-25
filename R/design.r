#' Download a survey's design
#'
#' Retrieve a representation of the elements in a survey and their
#' configuration.
#'
#' @inheritParams responses
#' @inheritParams request
#'
#' @return \code{design()} returns a \code{qualtrics_design} object, which is an
#' S3 class built from a list. 
#'
#' @seealso Download a survey's \code{\link{responses}},
#'   \code{\link{questions}}, or question \code{\link{choices}}.
#' @aliases qualtrics_design-class
#' @export
#' @examples
#' \dontrun{
#' design_object <- design("SV_0VVlb9QwJ4bsBKZ")
#' print(design_object)
#' }
design <- function(id, key = Sys.getenv("QUALTRICS_KEY"), subdomain =
  Sys.getenv("QUALTRICS_SUBDOMAIN"), verbose = FALSE) {

  assertthat::assert_that(assertthat::is.string(id))
  subdomain <- set_if_missing(subdomain)
  response <- request(action = paste0("surveys/", id), key = key, subdomain =
    subdomain, verbose = verbose)
  design_object <- httr::content(response, as = "parsed")$result
  design_object$json <- httr::content(response, as = "text")
  class(design_object) <- c("qualtrics_design", class(design_object))
  return(design_object)
}

print.qualtrics_design <- function(x) {

  for (nm in c("name", "id", "creationDate", "lastModifiedDate",
               "responseCounts", "questions", "blocks")) {
    assertthat::assert_that(assertthat::has_name(x, nm))
  }
  message('name:\t\t', x$name)
  message('id:\t\t\t', x$id)
  message("created:\t\t", lubridate::date(x$creationDate))
  message("modified:\t", lubridate::date(x$lastModifiedDate))
  message("responses:\t", x$responseCounts$auditable,
          ifelse(x[["isActive"]], " (active)", " (closed)"))
  message("questions:\t", length(x$questions))
  message("blocks:\t\t", length(x$blocks))
}

