test_that("print.qualtrics_design asserts that elements exist", {
  d = design("SV_cuxfjYWRTB30ouh")
  d$blocks = NULL
  expect_error(print(d), "d does not have name blocks")
})
