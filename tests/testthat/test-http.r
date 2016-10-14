test_that("bad endpoints lead to 404s", {
  api_key = "foo"
  expect_error(get(url = "https://az1.qualtrics.com/API/v3/", "foo"), "404")
  expect_error(post(url = "https://az1.qualtrics.com/API/v3/", "foo"), "404")
})
