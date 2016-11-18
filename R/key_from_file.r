#' Set the environment variable for the API key from a file
#'
#' The environment variable \code{QUALTRICS_KEY} should give an API key for
#' communication with the Qualtrics survey platform. \code{key_from_file} sets
#' it using the contents of a file.
#'
#' @param file A filename.
#' @param verbose Whether to print the result of reading from \code{file}, or
#'   not (the default).
#'
#' @return Invisibly returns the value of the environment variable
#'   \code{QUALTRICS_KEY}, after setting it as a side effect.
#' @export
#' @examples
#' \dontrun{
#' key = key_from_file()
#' identical(key, Sys.getenv("QUALTRICS_KEY"))
#' }
key_from_file = function(file = ".api_key", verbose = FALSE) {

  if (file.exists(file)) {
    f = readLines(file)
    if (length(f) && nchar(f[1])) {
      Sys.setenv("QUALTRICS_KEY" = f[1])
      if (isTRUE(verbose)) {
        message("Set API key: ", f[1])
      }
    } else {
      stop("Couldn't find key in ", file)
    }
  } else {
    stop("Couldn't read ", file)
  }
  invisible(Sys.getenv("QUALTRICS_KEY"))
}
