context("survey flow")

test_that("search_flow() handles block; block", {
  test_flow = list(
    list(type = "Block", id = "BL_1"),
    list(type = "Block", id = "BL_2"))
  class(test_flow) <- c("list", "qualtrics_design")
  expect_silent(search_flow(test_flow))
  res = search_flow(test_flow)
  expect_equal(res$id, c(1, 2))
  expect_equal(res$parent, c(0, 0))
  expect_equal(res$from, c(0, 1))
  expect_equal(res$node_type, rep("Block", 2))
  expect_equal(res$label, paste0("BL_", 1:2))
})

test_that("search_flow() handles WebService; block; branch -> blocks; block", {
  test_flow = list(
    list(type = "WebService"),
    list(id = "BL_1", type = "Block"),
    list(type = "Branch", flow = list(
      list(id = "BL_2", type = "Block"),
      list(id = "BL_3", type = "Block")
    )),
    list(id = "BL_4", type = "Block")
  )
  expect_silent(search_flow(test_flow))
  res = search_flow(test_flow)
  expect_equal(res$id, 1:6)
  expect_equal(res$parent, c(rep(0, 4), rep(3, 2)))
  expect_equal(res$node_type,c("WebService", "Block", "Branch", rep("Block", 3)))
  expect_equal(res$label, c(NA, "BL_1", NA, paste0("BL_", c(4, 2, 3))))
})

test_that("search_flow() handles branch->randomizer->blocks; block", {
  test_flow = list(
    list(type = "Branch",
      flow = list(
        list(type = "BlockRandomizer", flow = list(
            list(id = "BL_1", type = "Block"),
            list(id = "BL_2", type = "Block")
            ),
          randomizationOptions = list(randomSubset = 2)
          )
        )),
    list(id = "BL_3", type = "Block")
  )
  expect_silent(search_flow(test_flow))
  res = search_flow(test_flow)
  expect_equal(res$id, 1:5)
  expect_equal(res$parent, c(0, 0, 1, 3, 3))
  expect_equal(res$from, c(0, 1, 1, 3, 3))
  expect_equal(res$label, c(NA, "BL_3", "Randomize: 2 of 2", paste0("BL_", 1:2)))
  expect_equal(res$node_type, c("Branch", "Block", "BlockRandomizer", rep("Block", 2)))
})

test_that("search_flow() handles randomizer->blocks; block", {
  test_flow = list(
    list(type = "BlockRandomizer", flow = list(
        list(id = "BL_1", type = "Block"),
        list(id = "BL_2", type = "Block")
        ),
      randomizationOptions = list(randomSubset = 1)
      ),
    list(id = "BL_3", type = "Block")
  )
  expect_silent(search_flow(test_flow))
  res = search_flow(test_flow)
  expect_equal(res$id, 1:4)
  expect_equal(res$parent, c(0, 0, 1, 1))
  expect_equal(res$from, c(0, 1, 1, 1))
  expect_equal(res$node_type, c("BlockRandomizer", rep("Block", 3)))
  expect_equal(res$label, c("Randomize: 1 of 2", paste0("BL_", c(3, 1, 2))))
})
