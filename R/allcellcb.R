##' Lists all combinations of cell types
##' @title allcellcb
##' @param cellsets A vector containing the names of the cell types(length(cellsets)>=3) of interest.
##' @return A list containing all combinations of cell types
##' @importFrom utils combn
##' @author W Xie

allcellcb <- function(cellsets) {
  ncombn <- length(cellsets)
  cell.list <- lapply(2:ncombn, function(m) {
    combn(x = cellsets, m = m, simplify = FALSE)
  }) |> unlist(recursive = FALSE)

  return(cell.list)
}
