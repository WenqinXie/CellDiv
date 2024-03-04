##' The samples of the two conditions were counted respectively
##' @title samsizes
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @return A vector containing two numeric values representing the number of samples for the two types of conditions.
##' @author W Xie

samsizes <- function(metadata) {
  sams <- as.numeric(table(metadata$condition))
  names(sams) <- names(table(metadata$condition))
  return(sams)
}

##' Lists the sample names contained in the specified condition
##' @title sampcondi
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param condi A numeric, which can be 1 or 2, representing the first condition and the second condition respectively. The default value is 1
##' @return a vector containing all sample names in the specified condition
##' @author W Xie

# samples of condition
sampcondi <- function(metadata, condi = 1) {
  samsize <- samsizes(metadata)
  sampc <- metadata$sample[metadata$condition %in% names(samsize[condi])]
  return(sampc)
}
