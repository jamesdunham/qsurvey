#' Wrap GET requests
#'
#' Typically called by other functions, not directly. This function can be used
#' to access API endpoints without package functions. See the
#' \href{https://api.qualtrics.com}{API documentation}.
#'
#' @param url The base API URL
#' @param endpoint The endpoint name, e.g. \code{users}
#' @param query A named list of key-value pairs
#' @param ... Arguments passed to \link[httr]{content}
#'
#' @return The content of the request's response via \link[httr]{content}
#' @export
get = function(url = "https://az1.qualtrics.com/API/v3/", endpoint = NULL,
    query = NULL, ...)
{
  url = paste0(url, endpoint)
  headers = httr::add_headers("X-API-TOKEN" = get_api_key())
  r = httr::GET(url, headers, query = query)
  check_code(r)
  httr::content(r, ...)
}

#' Wrap POST requests
#'
#' Typically called by other functions, not directly. This function can be used
#' to access API endpoints without package functions. See the
#' \href{https://api.qualtrics.com}{API documentation}.
#'
#' @inheritParams get
#' @param body A named list of body data to post
#'
#' @return The content of the request's response via \link[httr]{content}
#' @export
post = function(url = "https://az1.qualtrics.com/API/v3/", endpoint = NULL,
  body = NULL, ...)
{
  url = paste0(url, endpoint)
  headers = httr::add_headers("x-api-token" = get_api_key(),
    "content-type" = "application/json")
  r =  httr::POST(url, headers, body = body, encode = "json")
  check_code(r)
  httr::content(r, ...)
}

check_code = function(r) {
  if (r$status_code != 200) {
    stop("http status code ", r$status_code)
  }
}
