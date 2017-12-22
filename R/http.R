#' Send a request to the Qualtrics API
#'
#' These are lower-level functions for direct access to API actions. They may be
#' useful in programming or when higher-level package functions are not
#' available. \code{qget} and \code{qpost} are wrappers for \code{request}.
#'
#' For help with subdomains, see the
#' \href{https://api.qualtrics.com/docs/root-url}{Qualtrics documentation}. Each
#' Qualtrics account is assigned a subdomain, and using another will work but
#' produce a warning.
#'
#' @inheritParams httr::VERB
#' @param subdomain A Qualtrics subdomain (by default, the value of the
#'   environment variable \code{QUALTRICS_SUBDOMAIN}).
#' @param action An API action (like \code{"surveys"}).
#' @param key A Qualtrics API key (by default, the value of the environment
#'   variable \code{QUALTRICS_KEY}).
#' @param api_url A complete API URL. If used, argument \code{action} and
#'   \code{subdomain} are ignored.
#' @param verbose Output API calls to \code{\link[base]{stderr}}.
#' @param ... Further arguments to \code{\link[httr]{GET}} or
#'   \code{\link[httr]{POST}}, depending on \code{verb}.
#'
#' @return For \code{request}, a \code{\link[httr]{response}} object. For
#'   \code{qget} and \code{qpost}, its content as extracted by
#'   \code{\link[httr]{content}}.
#' @importFrom httr GET POST VERB add_headers content modify_url stop_for_status
#' @export
request <- function(verb = "GET",
  action = NULL,
  key = Sys.getenv("QUALTRICS_KEY"),
  subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN"),
  api_url = NULL,
  verbose = FALSE,
  ...) {

  assert_key_set(key)
  subdomain <- set_if_missing(subdomain)
  assertthat::assert_that(assertthat::is.string(subdomain))
  assertthat::assert_that(assertthat::is.string(verb))
  assertthat::assert_that(assertthat::is.flag(verbose))

  if (!length(api_url)) {
    # if api_url wasn't given, expect action
    assertthat::assert_that(assertthat::is.string(action))
    api_url <- build_api_url(action, subdomain)
  } else {
    # if api_url was given, expect it as a string and ignore action
    assertthat::assert_that(assertthat::is.string(api_url))
  }

  if (verbose) {
    message("Sending ", verb, " request to ", api_url)
  }
  response <- httr::VERB(verb,
    api_url,
    add_qheaders(key),
    encode = ifelse(identical(verb, "POST"), "json", NULL),
    ...)
  httr::stop_for_status(response)
  warn_on_notice(response)
  return(response)
}


#' @rdname request
#' @aliases qget
#'
#' @param as Desired type of content. See \link[httr]{content}.
#'
#' @export
qget <- function(action = NULL,
  as = "parsed", 
  key = Sys.getenv("QUALTRICS_KEY"),
  subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN"),
  ...) {

  r <- request(verb = "GET", action = action, key = key, subdomain = subdomain,
    ...)
  httr::content(r, as = as, encoding = "UTF-8")
}

#' @rdname request
#' @aliases qpost
#'
#' @export
qpost <- function(action = NULL,
  as = "parsed",
  key = Sys.getenv("QUALTRICS_KEY"),
  subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN"),
  ...) {

  r <- request(verb = "POST", action = action, key = key, subdomain = subdomain,
    ...)
  httr::content(r, as = as, encoding = "UTF-8")
}

warn_on_notice <- function(response) {
  # If the meta element of the request response content has an element notice,
  # pass it on to the user as a warning. Known to happen if incorrect subdomain
  # is used.

  content <- httr::content(response)
  if ("meta" %in% names(content) && "notice" %in% names(content$meta)) {
    warning(content$meta$notice)
  }
}

add_qheaders <- function(key) {
  # Add Qualtrics headers to a httr request

  httr::add_headers("content_type" = "application/json", "x-api-token" = key)
}

set_if_missing <- function(subdomain) {
  # If the subdomain is a length-zero string, the environment variable
  # QUALTRICS_SUBDOMAIN hasn't been (properly) set. Return a valid subdomain to
  # be used (\code{az1}) and throw a warning.

  if (subdomain == "") {
    warning("Set the environment variable QUALTRICS_SUBDOMAIN for better performance. ",
      "See https://api.qualtrics.com/docs/root-url.")
    subdomain <- "az1"
  }
  return(subdomain)
}

build_api_url <- function(action, subdomain, query = NULL) {
  # Build a Qualtrics API URL from specified and fixed parts

  assertthat::assert_that(assertthat::is.string(subdomain))
  assertthat::assert_that(assertthat::is.string(action))

  httr::modify_url("",
    scheme = "https",
    hostname = paste(subdomain, "qualtrics.com", sep = "."),
    path = paste("API/v3", action, sep = "/"),
    query = query)
}
