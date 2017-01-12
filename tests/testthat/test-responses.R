# This id must reference a survey with responses for some of the following tests
# to pass
id = "SV_0CGgkDZJaUvxnGl"

test_that("responses() retrieves test survey responses", {
  expect_silent(r_defaults <- responses(id))
})

test_that("verbosity works", {
  expect_message(responses(id, verbose = TRUE), "Sending POST.*")
})

test_that("dots pass body params", {
  # see https://api.qualtrics.com/docs/json
  expect_silent(r_limit_1 <- responses(id, limit = 1))
  expect_true(identical(nrow(r_limit_1), 1L))
})

test_that("fixed body params cannot be passed through dots", {
  expect_error(responses(id, surveyId = 1))
  expect_error(responses(id, format = "csv"))
  expect_error(responses(id, useLabels = TRUE))
})
