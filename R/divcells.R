##' Calculate diversity scores(with metadata)
##' @title divcells
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param cdata A dataframe with row names for sample names and column names containing at least three cell type names.
##' @param slcells A vector containing selected cell types
##' @return a dataframe which the row names are the sample names,
##' and the column names are sample (sample name),
##' divscore (diversity score of the selected cell type),
##' and condition respectively.
##' @author W Xie

divcells <- function(cdata, metadata, slcells) {
  dat <- as.matrix(cdata[, slcells])
  dat <- proportions(dat, margin = 1)
  dat[is.na(dat)] <- 0
  divscore <- apply(dat, 1, function(x) {
    -sum(x * log(x + 1e-100))
  })
  divscoredf <- data.frame(sample = names(divscore), divscore = divscore)
  scoreifs <- merge(divscoredf, metadata, by = "sample", sort = FALSE)
  row.names(scoreifs) <- scoreifs$sample
  return(scoreifs)
}

##' Calculate diversity scores(without metadata)
##' @title celltdiv
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param cdata A dataframe with row names for sample names
##' and column names containing at least three cell type names.
##' @param cellsets A vector containing the names of
##' the cell types(length(cellsets)>=3) of interest.
##' @return a dataframe which the row names are the sample names,
##' and the column names are sample (sample name), divscore (diversity score of
##' the interested cell types), and condition respectively.
##' @examples
##' cellsets <- c("B.cells.naive", "B.cells.memory", "Plasma.cells")
##' cdata <- matrix(1:12, 3, 4)
##' row.names(cdata) <- c("A", "B", "C")
##' colnames(cdata) <- c("B.cells.naive", "B.cells.memory", "Plasma.cells",  "T.cells.CD8")
##' cdata <- cbind(as.data.frame(cdata), condition = c("R", "D", "R"))
##' celltdiv(cdata = cdata, cellsets = cellsets)
##' @export
##' @author W Xie

#Calculate diversity scores
celltdiv <- function(cdata, cellsets = NULL) {
  if (is.null(cellsets)){
    if(!(inherits(unlist(cdata),"integer") | inherits(unlist(cdata),"numeric"))){
      stop("The element in the dataframe should be numeric or integer")
    }else{
      cellsets = colnames(cdata)
    }
  }
  if(!(inherits(as.vector(as.matrix(cdata[, cellsets])),"integer") |
       inherits(as.vector(as.matrix(cdata[, cellsets])),"numeric"))){
    stop("The selected column is incorrect")
  }
  dat <- as.matrix(cdata[, cellsets])
  dat <- proportions(dat, margin = 1)
  dat[is.na(dat)] <- 0
  divscore <- apply(dat, 1, function(x) {
    -sum(x * log(x + 1e-100))
  })
  divscoredf <- data.frame(sample = names(divscore), divscore = divscore)
  return(divscoredf)
}


