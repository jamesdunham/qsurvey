library(testthat)

test_that("flow() handles block; block", {
  test_flow = list(
    list(type = "Block", id = "BL_1"),
    list(type = "Block", id = "BL_2"))
  expect_silent(flow(test_flow))
  res = search_flow(test_flow)
  expect_equal(res$node, c(1, 2))
  expect_equal(res$parent, c(0, 0))
  expect_equal(res$previous, c(0, 1))
  expect_equal(res$name, paste0("Block BL_", 1:2))
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
  res = search_flow(test_flow)
  plot_flow(res)
  expect_equal(res$node, 1:6)
  expect_equal(res$parent, c(rep(0, 4), rep(3, 2)))
  expect_equal(res$name, c("WebService", "Block BL_1", "Branch",
    paste0("Block BL_", c(4, 2, 3))))
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
  res = search_flow(test_flow)
  plot_flow(res)
  expect_equal(res$node, 1:5)
  expect_equal(res$parent, c(0, 0, 1, 3, 3))
  expect_equal(res$previous, c(0, 1, 1, 3, 3))
  expect_equal(res$name, c("Branch", "Block BL_3", "BlockRandomizer", paste0("Block BL_", 1:2)))
})

test_that("flow() handles randomizer->blocks; block", {
  test_flow = list(
        list(type = "BlockRandomizer", flow = list(
          list(id = "BL_1", type = "Block"),
          list(id = "BL_2", type = "Block")
        )),
    list(id = "BL_3", type = "Block")
  )
  expect_silent(flow(test_flow))
  res = search_flow(test_flow)
  plot_flow(res)
  expect_equal(res$node, 1:4)
  expect_equal(res$parent, c(0, 0, 1, 1))
  expect_equal(res$previous, c(0, 1, 1, 1))
  expect_equal(res$name, c("BlockRandomizer", paste0("Block BL_", c(3, 1, 2))))
})
