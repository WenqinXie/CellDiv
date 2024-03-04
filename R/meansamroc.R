##' Calculate The average AUC value for the specified times of sampling
##' @title meansamroc
##' @param sami the times of random sampling
##' @param samsize a vector containing two numeric values
##' representing the number of samples for the two types of conditions.
##' @param samp1 a vector containing all sample names in the first condition
##' @param samp2 a vector containing all sample names in the second condition
##' @param scoreif a dataframe which the row names are the sample names,
##' and the column names are sample (sample name),
##' divscore (diversity score of the selected cell type), and condition respectively.
##' @return a numeric representing the average AUC value for the specified times of sampling
##' @importFrom pROC roc
##' @author W Xie
##'
#mean of auc(Area Under the ROC Curve) of Multiple sampling
meansamroc <- function(sami, samsize, samp1, samp2, scoreif) {
  mroc <- c()
  for (sami in seq_len(sami)) {
    if (samsize[1] < samsize[2]) {
      divs1 <- scoreif[samp1, ]
      set.seed(sami)
      samp2.n <- sample(samp2, samsize[1])
      divs2 <- scoreif[samp2.n, ]
      divs.n <- rbind(divs1, divs2)
    } else {
      divs2 <- scoreif[samp2, ]
      set.seed(sami)
      samp1.n <- sample(samp1, samsize[2])
      divs1 <- scoreif[samp1.n, ]
      divs.n <- rbind(divs1, divs2)
    }
    rocs.n <- pROC::roc(
      data = divs.n, response = condition, predictor = divscore,
      levels = levels(divs.n$condition), direction = rocdir(scoreif = scoreif)
    )
    mroc <- c(mroc, rocs.n$auc)
  }
  meanroc <- mean(mroc)
  return(meanroc)
}
