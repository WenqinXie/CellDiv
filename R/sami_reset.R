##' Reset the sampling times forcibly if the data is balanced
##' @title sami reset
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param sami A numeric representing the times of random sampling
##' @return A numeric representing the times of random sampling taken after the reset
##' @author W Xie

sami_reset <- function(metadata, sami) {
  samsize <- as.numeric(table(metadata$condition))
  if (samsize[1] == samsize[2]) {
    sami <- 1
    message("The data is balanced and sami has been reset to 1 forcibly")
  }
  return(sami)
}
