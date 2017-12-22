#' Download a survey's design
#'
#' Retrieve a representation of the elements in a survey and their
#' configuration.
#'
#' @param id A Qualtrics survey identifier.
#' @inheritParams responses
#' @inheritParams request
#'
#' @return \code{design()} returns a \code{qualtrics_design} object, which is an
#' S3 class built from a list.
#'
#' @seealso \code{\link{responses}}
#' @aliases qualtrics_design-class
#' @export
#' @include http.R
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
  design_object <- httr::content(response, as = "parsed", encoding =
    "UTF-8")$result
  design_object$json <- httr::content(response, as = "text", encoding = "UTF-8")
  class(design_object) <- c("qualtrics_design", class(design_object))
  return(design_object)
}

#' @method print qualtrics_design
#' @export
print.qualtrics_design <- function(x, ...) {

  for (nm in c("name", "id", "creationDate", "lastModifiedDate",
               "responseCounts", "questions", "blocks")) {
    assertthat::assert_that(assertthat::has_name(x, nm))
  }
  message(format(
    c("# A qualtrics_design:",
      "\nname", x$name,
      "\nid", x$id,
      "\ncreated", format(lubridate::date(x$creationDate)),
      "\nmodified", format(lubridate::date(x$lastModifiedDate)),
      "\nresponses", paste0(x$responseCounts$auditable, ifelse(x[["isActive"]], " (active)", " (closed)")),
      "\nquestions", length(x$questions),
      "\nblocks", length(x$blocks)),
    ))
}
