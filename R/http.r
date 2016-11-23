#' Send GET and POST requests to the Qualtrics API
#'
#' These are lower-level functions for direct access to API actions. They may be
#' useful in programming or when higher-level package functions are not
#' available. \code{qget} and \code{qpost} are wrappers for \code{request}.
#'
#' For help specifying valid subdomains and API actions, see the
#' \href{https://api.qualtrics.com/docs/root-url}{Qualtrics documentation}.
#'
#' If \code{test} is \code{TRUE}, the API key is removed, and then the request
#' is sent to the value of \code{paste0("https://httpbin.org/", tolower(verb)}.
#'
#' @inheritParams httr::VERB
#' @param subdomain A Qualtrics subdomain.
#' @param action An API action (like \code{"surveys"}).
#' @param key A Qualtrics API key (by default, the value of the environment
#'   variable \code{QUALTRICS_KEY}).
#' @param test Whether to send the request to \url{https://httpbin.org} for
#'   testing purposes, rather than to the Qualtrics API.
#' @param ... Further arguments to \code{\link[httr]{GET}} or
#'   \code{\link[httr]{POST}}, depending on \code{verb}.
#'
#' @return For \code{request}, a \code{\link[httr]{response}} object. For
#'   \code{qget} and \code{qpost}, its content as extracted by
#'   \code{\link[httr]{content}}.
#' @export
request = function(verb = "GET",
  subdomain = "az1",
  action = NULL,
  key = Sys.getenv("QUALTRICS_KEY"),
  test = FALSE,
  ...) {

  url = paste0("https://",
    # FIXME: az1 load-balancing subdomain is hardcoded
    paste("az1", "qualtrics.com/API/v3/", sep = "."),
    action)
  if (!test && (length(key) != 1 || !is.character(key) || key == "")) {
      stop("Qualtrics API key needed. Set the environment variable QUALTRICS_KEY")
  }
  if (test) {
    message("replacing ", url, " with httpbin.org URL for test")
    url = paste0("https://httpbin.org/", tolower(verb))
    key = NA
  }
  if (identical(verb, "POST")) {
    headers = httr::add_headers("content_type" = "application/json",
      "x-api-token" = key)
    r = httr::POST(url, headers, encode = "json", ...)
  } else if (identical(verb, "GET")) {
    headers = httr::add_headers("content_type" = "application/json",
      "x-api-token" = key)
    r = httr::GET(url, headers, ...)
  }
  httr::stop_for_status(r)
  r_content = httr::content(r)
  if ("meta" %in% names(r_content) && "notice" %in% names(r_content$meta)) {
    warning(r_content$meta$notice)
  }
  return(r)
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

  r = request(verb = "POST", action = action, body, ...)
  httr::content(r, as = as)
}
