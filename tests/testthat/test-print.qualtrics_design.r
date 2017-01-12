svy_tbl <- surveys()

test_that("print.qualtrics_design asserts that elements exist", {
  d = design(svy_tbl$id[1])
  d$blocks = NULL
  expect_error(print(d), "x does not have name blocks")
})

test_that("print dispatches print.qualtrics_design", {
  d = design(svy_tbl$id[1])
  expect_message(print(d), "# A qualtrics_design:.*blocks\\s+\\d+\\s+")
})
