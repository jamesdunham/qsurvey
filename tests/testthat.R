library(testthat)
library(qsurvey)

if (Sys.getenv("QUALTRICS_KEY") == "") {
  stop("Tests require the environment variable QUALTRICS_KEY. See ",
    "https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Checking-and-building-packages")
}
test_check("qsurvey")
