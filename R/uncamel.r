uncamel <- function(nms) {
  sapply(nms, function(x) {
    # first pass: aB -> a_B
    x = gsub("([[:lower:]])([[:upper:]])", "\\1_\\2", x)
    # second pass: a_B -> a_b
    tolower(x)
  })
}
