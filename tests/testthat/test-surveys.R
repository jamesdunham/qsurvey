context("surveys")

test_that("surveys() gives expected output", {
  svy_tbl <- surveys()
  expect_named(svy_tbl, c("id", "name", "owner_id", "last_modified",
      "is_active"), ignore.order = TRUE)
})
