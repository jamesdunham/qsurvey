#' Make GET requests
#'
#' This function can be used to access API endpoints for which higher-level
#' package functions are not available.
#'
#' @param url The base API URL
#' @param endpoint The endpoint name, e.g. \code{users}
#' @param as Passed to \link{httr}[content]
#' @param ... Arguments passed to \link[httr]{GET}
#'
#' @return The content of the request's response via \link[httr]{content}
#' @export
qget = function(url = "https://az1.qualtrics.com/API/v3/", endpoint = NULL,
    as = "parsed", ...)
{
  url = paste0(url, endpoint)
  headers = httr::add_headers("X-API-TOKEN" = get_api_key())
  r = httr::GET(url, headers, ...)
  check_code(r)
  httr::content(r, as = as)
}

#' Make POST requests
#'
#' This function can be used to access API endpoints for which higher-level
#' package functions are not available.
#'
#' @inheritParams qget
#' @param body A named list of body data to post
#'
#' @return The content of the request's response via \link[httr]{content}
#' @export
qpost = function(url = "https://az1.qualtrics.com/API/v3/", endpoint = NULL,
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
