test_that("bad endpoints lead to 404s", {
  api_key = "foo"
  expect_error(qget(url = "https://httpbin.org/hidden-basic-auth/user/passwd", "foo"), "404")
  expect_error(qpost(url = "https://httpbin.org/hidden-basic-auth/user/passwd"), "405")
})
