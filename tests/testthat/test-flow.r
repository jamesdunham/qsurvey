library(testthat)

test_that("flow() handles block; block", {
  test_flow = list(
    list(type = "Block", id = "BL_1"),
    list(type = "Block", id = "BL_2"))
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  plot_flow(res)
  expect_equal(res$id, c(1, 2))
  expect_equal(res$parent, c(0, 1))
  expect_equal(res$type, c("Block", "Block"))
})

test_that("flow() handles WebService; block; branch -> blocks; block", {
  test_flow = list(
    list(type = "WebService"),
    list(id = "BL_1", type = "Block"),
    list(type = "Branch", flow = list(
      list(id = "BL_2", type = "Block"),
      list(id = "BL_3", type = "Block")
    )),
    list(id = "BL_4", type = "Block")
  )
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  plot_flow(res)
  expect_equal(res$id, 1:6)
  expect_equal(res$parent, c(0:4, 2))
  expect_equal(res$type, c("WebService", "Block", "Branch", rep("Block", 3)))
  expect_equal(res$block_id, c(NA, "BL_1", NA, paste0("BL_", 2:4)))
})

test_that("flow() handles branch->randomizer->blocks; block", {
  test_flow = list(
    list(type = "Branch",
      flow = list(
        list(type = "BlockRandomizer", flow = list(
          list(id = "BL_1", type = "Block"),
          list(id = "BL_2", type = "Block")
        ))
      )),
    list(id = "BL_3", type = "Block")
  )
  expect_silent(flow(test_flow))
  res = flow(test_flow)
  plot_flow(res)
  expect_equal(res$id, 1:5)
  expect_equal(res$parent, c(0, 1, 2, 2, 0))
  expect_equal(res$type, c("Branch", "BlockRandomizer", rep("Block", 3)))
  expect_equal(res$block_id, c(NA, NA, "BL_1", "BL_2", "BL_3"))
})
