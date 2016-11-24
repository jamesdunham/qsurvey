test_that("assert_key_set works", {
  expect_error(assert_key_set(""), "Set the environment variable QUALTRICS_KEY.")
  expect_true(assert_key_set("foo"))
})
