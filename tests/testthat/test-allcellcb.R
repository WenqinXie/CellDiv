
test_that("allcellcb() List all combinations", {
  expect_equal(allcellcb(c("A", "B", "C")),
               list(c("A", "B"), c("A", "C"), c("B", "C"), c("A", "B", "C")))
})
