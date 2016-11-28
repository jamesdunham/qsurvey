test_that("drop_sensitive drops sensitive columns", {
  test_tbl = data.frame(
    "LocationLongitude" = character(),
    "LocationAccuracy" = character(),
    "IPAddress" = character(),
    "RecipientLastName" = character(),
    "RecipientFirstName" = character(),
    "RecipientEmail" = character())
  expect_true(length(drop_sensitive(test_tbl)) == 0)
})

test_that("drop_sensitive is silent about missing sensitive columns", {
  test_tbl = data.frame("RecipientEmail" = character())
  expect_true(length(drop_sensitive(test_tbl)) == 0)
  expect_silent(drop_sensitive(test_tbl))
})
