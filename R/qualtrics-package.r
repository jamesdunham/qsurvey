#' qualtrics
#'
#' This package aims to make working with Qualtrics surveys in R easier. Main
#' features:
#'
#' \itemize{
#'   \item Download survey responses into an R session
#   \item Import and export survey designs
#'   \item Download survey designs
#   \item Set active/closed status and expiration dates
#'   \item List survey metadata (e.g. active/closed status and expiration dates)
#'   \item Drop sensitive fields from survey responses
#   \item Upload images to the graphics library
#' }
#'
#' The package works by sending requests to the Qualtrics API. For
#' authentication, an API key is needed. The package looks for it first in the
#' current working directory in the file \code{.api_key}, and then as a global
#' variable \code{api_key}.
#'
#' qualtrics focuses on survey responses and designs. To access API endpoints
#' that are not available through package functions, \code{\link{qget}} and
#' \code{\link{qpost}} request wrappers are available.
#'
#' I'm aware of two other Qualtrics packages.
#' \href{https://github.com/jbryer/qualtrics}{Jason Bryer} wrote one in 2012.
#' \href{https://github.com/ericpgreen/qualtrics}{Eric Green} forked and revised
#' it for v2.3 of the Qualtrics API, most recently in 2014.
#'
#' @name qualtrics
#' @docType package
#' @import assertthat data.table jsonlite
NULL
