test_that("print.qualtrics_design asserts that elements exist", {
  key_from_file()
  d = survey_design("SV_cuxfjYWRTB30ouh")
  d$blocks = NULL
  expect_error(print(x), "d does not have name blocks")
})
