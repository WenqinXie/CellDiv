cdata <- data.frame("B.cells.naive" = c(3, 2), "B.cells.memory" = c(3, 2),
                    "Plasma.cells" = c(3, 2), "T.cells.CD8" = c(3, 4),
                    "condition" = c("R", "D"))
cellsets <- c("B.cells.naive", "B.cells.memory", "Plasma.cells",  "T.cells.CD8")
row.names(cdata) <- c("A", "B")

expectvalue <- data.frame(sample = c("A", "B"),
                          divscore = c(-3/12*log(3/12+1e-100)*4,
                                       -2/10*log(2/10+1e-100)*3-4/10*log(4/10+1e-100)))
row.names(expectvalue) <- expectvalue$sample

test_that("celltdiv() Calculate diversity scores", {

  expect_equal(celltdiv(cdata = cdata, cellsets = cellsets),
               expectvalue)
})

