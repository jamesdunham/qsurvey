#' The qualtrics package: overview
#'
#' A toolkit for working with the Qualtrics platform and its survey data in R.
#'
#' Main features:
#'
#' \itemize{
#'   \item Download survey \link{responses} into an R session
#   \item Import and export survey designs
#'   \item Download a survey \link{design}
#   \item Set active/closed status and expiration dates
#'   \item \link[=surveys]{List survey metadata} (e.g. active/closed status and
#'   expiration dates)
#'   \item \link[=drop_sensitive]{Drop sensitive fields} from survey responses
#   \item Upload images to the graphics library
#' }
#'
#' The package works by sending requests to the Qualtrics API. For
#' authentication, an API key is needed. The key should be set with the
#' environmental variable \code{QUALTRICS_KEY}  (See  \link[base]{Sys.setenv}.)
#'
#' Functionality focuses on retrieving survey responses and survey attributes.
#' But to access API actions that are not available through higher-level package
#' functions, use \code{\link{qget}}, \code{\link{qpost}}, or
#' \code{\link{request}}.
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
