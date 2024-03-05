##' Plot the diversity score comparison between the two conditions
##' @title plotCC
##' @param data A dataframe containing three coloums:"sample", "divscore", "condition"
##' @param x A "character"
##' @param y A "character"
##' @param xlabs xlabs
##' @param ylabs ylabs
##' @param color a vector containing a set of aesthetic values
##' @inheritParams ggpubr::stat_compare_means
##' @return a plot of the difference of diversity scores
##' @import ggplot2
##' @import gghalves
##' @import ggpubr
##' @examples
##' set.seed(1)
##' data1 <- data.frame(sample = c(paste0("A", 1:50)),
##' divscore = runif(50, min = 0, max = 0.7),
##' condition = rep("condition1", 50))
##' set.seed(1)
##' data2 <- data.frame(sample = c(paste0("A", 1:50)),
##' divscore = runif(50, min = 0.7, max = 1.3),
##' condition = rep("condition2", 50))
##' data = rbind(data1, data2)
##' plotCC(data = data, x = "condition", y = "divscore",
##' xlabs = "Condition", ylabs = "DiversityScore",
##' color = c("#00AED7", "#FD9347"),
##' label.x = 1.5, label.y = 1.7,
##' comparisons = NULL)
##' @export
##' @author W Xie

plotCC <- function(data, x = "condition", y = "divscore",
                   xlabs = "Condition", ylabs = "DiversityScore",
                   method = "wilcox.test",paired = FALSE,
                   method.args = list(), ref.group = NULL,
                   comparisons = NULL, hide.ns = FALSE,
                   label.x = 1.5,  label.y = 2,
                   label = "p.format",
                   color = NULL){
  p <- ggplot2::ggplot(data, ggplot2::aes_string(x = x, y = y, fill = x)) +
    gghalves::geom_half_violin(
      trim = FALSE, position = ggplot2::position_nudge(x = 0.15),
      width = 1.35, side = "r"
    ) +
    ggplot2::geom_jitter(ggplot2::aes_string(color = x), width = 0.05) +
    ggplot2::geom_boxplot(
      position = ggplot2::position_nudge(x = 0.15), outlier.size = 0,
      width = 0.15, show.legend = FALSE
    ) +
    ggplot2::xlab(xlabs) +
    ggplot2::ylab(ylabs) +
    ggpubr::stat_compare_means(method = method,
                               paired = paired, method.args = method.args,
                               ref.group = ref.group, comparisons = comparisons,
                               hide.ns = hide.ns, label.x = label.x,
                               label.y = label.y,
                               label = label) +
    ggplot2::theme_bw() +
    ggplot2::theme(
      legend.title = ggplot2::element_blank(),
      legend.position='none',
      axis.text.x = ggplot2::element_text(size = 16, colour = "black"),
      axis.text.y = ggplot2::element_text(size = 16, colour = "black"),
      axis.title.y = ggplot2::element_text(size = 20, face = "bold"),
      axis.title.x = ggplot2::element_text(size = 20, face = "bold"),
      panel.grid.major = ggplot2::element_blank(),
      panel.grid.minor = ggplot2::element_blank()
    )

  if (is.null(color)){
    p <- p
  }else{
    p <- p +
      ggplot2::scale_fill_manual(values = color) +
      ggplot2::scale_color_manual(values = color)
  }
  return(p)
}


