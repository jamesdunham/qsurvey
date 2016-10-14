#' Get the Qualtrics API base URL
#'
#' @return A string giving the base API URL
#' @export
#'
#' @examples
# get_api_url = function() {
#   url = tryCatch(mget("api_url", .GlobalEnv), error = function(e) {NULL})
#   if (length(url)) {
#     url = unlist(unname(url))
#   } else {
#
#   }
# }
#   if (!length(url)) {
#     stop("api url not found in '.api_url' file or in .GlobalEnv as 'api_url'")
#   } else {
#     return(url)
#   }
# }
