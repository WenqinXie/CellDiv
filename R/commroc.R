##' Calulate average AUC values of specified times of sampling for all combinations
##' @title commroc
##' @param metadata A dataframe containing the 'sample' and 'condition' columns.
##' The class of "condition" should be factor, and levels of "condition" should be "2".
##' @param cdata A dataframe with row names for sample names
##' and column names containing at least three cell type names.
##' @param cellsets A vector containing the names of the cell types(length(cellsets)>=3) of interest.
##' @param sami A integer repersenting the times of random sampling, defualt value is 500.
##' @param ncores the number of CPU cores to use,
##' for Linux systerm,default value is detected the number of CPU cores on the current host - 1
##' @return a dataframe, which one column is roc.auc(mean of ROC value for all combinations)
##' and the other column is cellsets(cell types).
##' @description
##' The function calculates all combinations of the cell types of interest and then the average AUC value for the times of user-specified sampling under each combination
##'
##' @importFrom parallel detectCores
##' @importFrom parallel mclapply
##' @examples
##' set.seed(1)
##' cdata <- matrix(sample(100:300, 100, replace = TRUE), 20, 5)
##' row.names(cdata) <- paste0("A",1:20)
##' colnames(cdata) <- c("B.cells.naive", "B.cells.memory", "Plasma.cells",
##' "T.cells.CD8", "T.cells.CD4.naive")
##' cdata <- as.data.frame(cdata)
##' set.seed(1)
##' metadata <- data.frame(sample = row.names(cdata),
##' condition = sample(c("CR/PR", "SD/PD"), 20, replace = TRUE))
##' metadata$condition <- as.factor(metadata$condition)
##' cellsets <- c("B.cells.naive", "B.cells.memory", "Plasma.cells", "T.cells.CD8")
##' sami = 5
##' commroc(cdata = cdata, metadata = metadata, cellsets = cellsets, sami = sami, ncores = 2)
##' @export
##' @author W Xie


commroc <- function(cdata, metadata, cellsets, sami = 500,
                    ncores = (parallel::detectCores() - 1)) {
  if(Sys.info()[1] == "Linux"){
    ncores = ncores
  }else{
    ncores = 1
    message("The system is windows, reset ncores to 1")
  }
  checkinput(metadata = metadata, cdata = cdata, cellsets = cellsets)
  sami <- sami_reset(metadata = metadata, sami = sami)
  cells_combn <- allcellcb(cellsets = cellsets)
  samsize <- samsizes(metadata = metadata)
  samp1 <- sampcondi(metadata = metadata, condi = 1)
  samp2 <- sampcondi(metadata = metadata, condi = 2)

  allcomroc <-
    parallel::mclapply(seq_along(cells_combn), function(lx) {
      slcells <- cells_combn[[lx]]
      scoreif <- divcells(cdata = cdata, slcells = slcells, metadata = metadata)
      mean_mroc <- meansamroc(sami, samsize, samp1, samp2, scoreif)
      cellcm <- paste0(cells_combn[[lx]], collapse = "; ")
      allcrc <- c(mean_mroc, cellcm)
    }, mc.cores = ncores)

  allcomroc <- do.call(rbind, allcomroc)
  allcomroc <- as.data.frame(allcomroc)
  colnames(allcomroc) <- c("roc.auc", "cellsets")
  allcomroc$roc.auc <- as.numeric(allcomroc$roc.auc)
  return(allcomroc)
}

##' Selecte the combination of cell types corresponding to the maximum AUC value
##' @title maxroc
##' @param acroc a dataframe, which one column is roc.auc(mean of ROC value for all combinations)
##' and the other column is cellsets(cell types)
##' @examples
##' acroc <- data.frame(roc.auc = c(0.440625, 0.493750, 0.690625),
##'   cellsets = c("B.cells.naive; B.cells.memory; Plasma.cells",
##'     "B.cells.naive; B.cells.memory; T.cells.CD8",
##'     "B.cells.naive; Plasma.cells; T.cells.CD8"))
##' maxroc(acroc = acroc)
##' @export
##' @author W Xie

maxroc <- function(acroc){
  aroc <- acroc$roc.auc
  max.roc <- max(aroc)
  res <- subset(acroc, roc.auc == max.roc)
  return(res)
}

