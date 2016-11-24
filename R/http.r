#' Send GET and POST requests to the Qualtrics API
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
#'   environment variable \code{QUALTRICS_SUBDOMAIN}.
#' @param action An API action (like \code{"surveys"}).
#' @param key A Qualtrics API key (by default, the value of the environment
#'   variable \code{QUALTRICS_KEY}).
#' @param ... Further arguments to \code{\link[httr]{GET}} or
#'   \code{\link[httr]{POST}}, depending on \code{verb}.
#'
#' @return For \code{request}, a \code{\link[httr]{response}} object. For
#'   \code{qget} and \code{qpost}, its content as extracted by
#'   \code{\link[httr]{content}}.
#' @export
request = function(verb = "GET",
  subdomain = Sys.getenv("QUALTRICS_SUBDOMAIN"),
  action = NULL,
  key = Sys.getenv("QUALTRICS_KEY"),
  ...) {

  assert_key_set(key)
  subdomain = set_if_missing(subdomain)
  assertthat::assert_that(assertthat::is.string(verb))
  assertthat::assert_that(assertthat::is.string(subdomain))
  assertthat::assert_that(assertthat::is.string(action))

  url = paste0("https://",
    paste(subdomain, "qualtrics.com/API/v3/", sep = "."),
    action)

  if (verb == "POST") {
    response = httr::POST(url, add_qheaders(key), encode = "json", ...)
  } else if (verb == "GET") {
    response = httr::GET(url, add_qheaders(key), ...)
  }

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
qget = function(action = NULL, as = "parsed", ...) {

  r = request(verb = "GET", action = action, ...)
  httr::content(r, as = as)
}

#' @rdname request
#' @aliases qpost
#'
#' @export
qpost = function(action = NULL, as = "parsed", ...) {

  r = request(verb = "POST", action = action, ...)
  httr::content(r, as = as)
}

warn_on_notice = function(response) {
  # If the meta element of the request response content has an element notice,
  # pass it on to the user as a warning. Known to happen if incorrect subdomain
  # is used.

  content = httr::content(response)
  if ("meta" %in% names(content) && "notice" %in% names(content$meta)) {
    warning(content$meta$notice)
  }
}

add_qheaders = function(key) {
  # Add Qualtrics headers to a httr request

  httr::add_headers("content_type" = "application/json", "x-api-token" = key)
}

set_if_missing = function(subdomain) {
  # If the subdomain is a length-zero string, the environment variable
  # QUALTRICS_SUBDOMAIN hasn't been (properly) set. Return a valid subdomain to
  # be used and throw a warnning.

  if (subdomain == "") {
    warning("Set the environment variable QUALTRICS_SUBDOMAIN for better performance. ",
      "See https://api.qualtrics.com/docs/root-url.")
    subdomain = "az1"
  }
  return(subdomain)
}

assert_key_set = function(key) {
  # A key should be provided in the call to request() or set by the user and
  # retrieved by Sys.getenv(). If not, stop.

  assertthat::assert_that(assertthat::is.string(key))
  if (key == "") {
    stop("Qualtrics API key needed. Set the environment variable QUALTRICS_KEY.")
  } else {
    return(TRUE)
  }
}
