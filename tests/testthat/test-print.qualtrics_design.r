test_that("print.qualtrics_design asserts that elements exist", {
  svy_tbl <- surveys()
  d = design(svy_tbl$id[1])
  d$blocks = NULL
  expect_error(print(d), "x does not have name blocks")
})
