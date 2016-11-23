#' The qsurvey package: overview
#'
#' qsurvey is a toolkit for working with the Qualtrics platform and its survey data in R.
#' Download responses and designs directly into a session, then:
#'
#' \itemize{
#' \item Examine branching, randomization, and question attributes like validation
#' \item Represent survey flows as directed graphs for interactive review in Shiny
#' \item Map question ids to labels and translate between choice codes and
#' descriptions in response data
#' }
#'
#' The package works by sending requests to the Qualtrics API. For
#' authentication, an API key is needed. See the
#' \href{Qualtrics
#' documentation}{https://www.qualtrics.com/support/integrations/api-integration/api-integration}.
#' The key should be set with the environment variable \code{QUALTRICS_KEY} (see
#' \link[base]{Sys.setenv}) or the \code{key_from_file} function.
#'
#' Functionality focuses on testing and review of surveys, before fielding, and
#' analysis of responses afterward. To access API actions that are not available
#' through higher-level package functions, use \code{\link{qget}},
#' \code{\link{qpost}}, or \code{\link{request}}.
#'
#' I'm aware of two other Qualtrics packages.
#' \href{Jason Bryer}{https://github.com/jbryer/qualtrics} wrote one in 2012.
#' \href{Eric Green}{https://github.com/ericpgreen/qualtrics} forked and revised
#' it for v2.3 of the Qualtrics API, most recently in 2014. I started qsurvey
#' while staffing \href{MIT PERL}{http://web.mit.edu/polisci/research/perl.html}.
#'
#' @name qsurvey
#' @docType package
#' @import assertthat data.table jsonlite magrittr shiny
NULL
