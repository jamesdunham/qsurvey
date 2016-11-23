library(testthat)
library(qsurvey)

key_from_file(system.file(".api_key", package = "qsurvey"))
test_check("qualtrics")
