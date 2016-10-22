#' Make requests of the Qualtrics API
#'
#' @inheritParams httr::VERB
#' @param subdomain A Qualtrics subdomain, e.g. \code{"ca1"}; see the
#'   \href{https://api.qualtrics.com/docs/root-url}{Qualtrics documentation}
#' @param endpoint An API endpoint, e.g., \code{"surveys"}
#' @param key A Qualtrics API key
#' @param test Whether to send the request to \url{https://httpbin.org} for
#'   testing purposes
#' @param ... Further arguments to \link[httr]{GET} or \link[httr]{POST},
#'   depending on \code{verb}
#'
#' @return A \link[httr]{response} object
#' @export
request = function(verb = "GET",
  subdomain = "az1",
  endpoint = NULL,
  key = Sys.getenv("QUALTRICS_KEY"),
  test = FALSE,
  ...)
{
  url = paste0(
    "https://",
    paste(subdomain, "qualtrics.com/API/v3/", sep = "."),
    endpoint
  )
  if (!test && (length(key) != 1 || !is.character(key) || key == "")) {
      stop("Qualtrics API key needed\nSet the environment variable QUALTRICS_KEY")
  }
  if (test) {
    message("replacing ", url, " with httpbin.org URL for test")
    url = paste0("https://httpbin.org/", tolower(verb))
    key = NA
  }
  if (identical(verb, "POST")) {
    headers = httr::add_headers("content_type" = "application/json",
      "x-api-token" = key)
    r = httr::POST(url, headers, ...)
  } else if (identical(verb, "GET")) {
    headers = httr::add_headers("X-API-TOKEN" = key)
    r = httr::GET(url, headers, ...)
  }
  httr::stop_for_status(r)
  if (length(httr::content(r)$meta$notice)) {
    warning(httr::content(r)$meta$notice)
  }
  return(r)
}

#' Make GET requests
#'
#' Use this function to access API endpoints for which higher-level package
#' functions are not available.
#'
#' @inheritParams request
#' @param as Passed to \link{httr}[content]
#'
#' @return The content of the response via \link[httr]{content}
#' @export
qget = function(endpoint = NULL, as, ...)
{
  r = request(verb = "GET", endpoint = endpoint, ...)
  httr::content(r, as = as)
}

#' Make POST requests
#'
#' Use this function to access API endpoints for which higher-level package
#' functions are not available.
#'
#' @inheritParams qget
#' @param body A named list of body data to post
#'
#' @return The content of the request's response via \link[httr]{content}
#' @export
qpost = function(endpoint = NULL, as, ...)
{
  r = request(verb = "POST", endpoint = endpoint, ...)
  httr::content(r, as = as)
}
