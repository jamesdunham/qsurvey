test_that("uncamel works", {
  expect_equal(unname(uncamel(c("abCd", "abcd", "Abc", "ab_cd", "ab_Cd"))),
    c("ab_cd", "abcd", "abc", "ab_cd", "ab_cd"))
})

