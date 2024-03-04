##' Determine the direction of ROC by using all samples
##' @title rocdir
##' @param scoreif A dataframe which the row names are the sample names,
##' and the column names are sample (sample name),
##' divscore (diversity score of the selected cell type), and condition respectively.
##' @return direction symbol: "<" or ">"
##' @importFrom stats aggregate
##' @importFrom stats median
##' @author W Xie
#Determine the direction of ROC by using all samples
rocdir <- function(scoreif) {
  dirs <- aggregate(scoreif$divscore, list(scoreif$condition), median)
  if (dirs[1, 2] > dirs[2, 2]) {
    directions <- ">"
  } else {
    directions <- "<"
  }
  return(directions)
}

