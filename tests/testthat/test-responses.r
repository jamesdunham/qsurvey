svy_tbl <- surveys()

test_that("responses() retrieves test survey responses", {
  responses_defaults = lapply(svy_tbl$id, responses)
  # ...
})

test_that("verbosity works", {
  expect_message(responses(svy_tbl$id[1], verbose = TRUE), "Sending POST.*")
})

test_that("dots pass body params", {
  # see https://api.qualtrics.com/docs/json
  expect_silent(r_limit_1 <- responses(svy_tbl$id[2], limit = 1))
  expect_true(identical(nrow(r_limit_1), 1L))
})

test_that("fixed body params cannot be passed through dots", {
  expect_error(responses(svy_tbl$id[1], surveyId = 1))
  expect_error(responses(svy_tbl$id[1], format = "csv"))
  expect_error(responses(svy_tbl$id[1], useLabels = TRUE))
})
