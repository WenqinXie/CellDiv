##' Check input data
##'
##' @title checkinput
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param cdata A dataframe with row names for sample names and column names containing at least three cell type names.
##' @param cellsets A vector containing the names of the cell types(length(cellsets)>=3) of interest.
##'
##' @description
##' What this function does is check:
##' 1. Whether the class of each input data is correct
##' 2. whether the sample names of "metadata" and "cdata" are the same.
##' 3. whether the class of the "condition" is factor, and there are only two levels;
##' 4. Whether length(cellsets)>=3
##' If the above conditions are met, the execution continues, otherwise, it will be stopped
##' @author W Xie


# check whether the input data meets the relevant criteria
checkinput <- function(metadata, cdata, cellsets) {
  if(!inherits(metadata, "data.frame")){
    stop("class of metadata should be data.frame")
  }

  if(!inherits(cdata, "data.frame")){
    stop("class of cdata should be data.frame or matrix")
  }

  if(!inherits(cellsets, "character")){
    stop("class of cellsets should be character")
  }

  if (!all(c("sample", "condition") %in% colnames(metadata))) {
    stop("metadata needs to contain the 'sample' and 'condition' columns")
  }

  if (!inherits(metadata$condition, "factor")) {
    stop("class of condition of metadata should be factor")
  }

  if (!length(levels(metadata$condition)) == 2) {
    stop("levels of condition of metadata should be 2")
  }

  if (!setequal(row.names(cdata), metadata$sample)) {
    stop("The metadata and cdata samples are inconsistent")
  }

  if (!length(cellsets) >= 3) {
    stop("The interest cellsets should be at least 3")
  }
}
