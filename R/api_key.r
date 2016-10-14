#' Get the Qualtrics API key
#'
#' The user is expected to save their Qualtrics API key either in a file named
#' \code{.api_key} in the working directory or as a global variable named
#' \code{api_key}. This function looks for the key in each place and returns it
#' if successful.
#'
#' @return A string giving an API key
#' @export
get_api_key = function() {
  if (file.exists(".api_key")) {
    key = readLines(".api_key")
    key = trimws(key[1])
  } else {
    key = tryCatch(mget("api_key", .GlobalEnv), error = function(e) {NULL})
    key = unlist(unname(key))
  }
  if (!length(key)) {
    stop("api key not found in '.api_key' file or in .GlobalEnv as 'api_key'")
  } else {
    return(key)
  }
}
