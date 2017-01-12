test_that("blocks() gets ids and descriptions", {
  test_design = list(
    blocks = list(
      BL_1 = list(description = "block 1",
                  elements = list(
                                  list(type = "Question",
                                       questionId = "QID1")
                                  )
                  ),
      BL_2 = list(description = "block 2",
                  elements = list(
                                  list(type = "Question",
                                       questionId = "QID2")
                                  ),
                                  list(type = "Question",
                                       questionId = "QID3")
                                  )
      ))
  class(test_design) <- "qualtrics_design"
  expect_silent(blocks(test_design))
  res = blocks(test_design)
  expect_equal(res$block_id, paste0("BL_", 1:2))
  expect_equal(res$block_description, paste0("block ", 1:2))
})

test_that("elements = TRUE adds element details", {
  test_design = list(
    blocks = list(
      BL_1 = list(description = "block 1",
                  elements = list(
                                  list(type = "Question",
                                       questionId = "QID1")
                                  )
                  ),
      BL_2 = list(description = "block 2",
                  elements = list(
                                  list(type = "Question",
                                       questionId = "QID2")
                                  ),
                                  list(type = "Question",
                                       questionId = "QID3")
                                  )
      ))
  class(test_design) <- "qualtrics_design"
  res = blocks(test_design, elements = TRUE)
  expect_equal(res$block_id, paste0("BL_", 1:2))
  expect_equal(res$block_description, paste0("block ", 1:2))
  expect_equal(res$element_type, rep("Question", 2))
  expect_equal(res$question_id, paste0("QID", 1:2))
})
