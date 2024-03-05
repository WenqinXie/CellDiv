##' plot selected cell types proportion
##' @title plotProp
##' @param cdata a dataframe or matrix with row names
##' for sample names and column names containing at least three cell type names
##' @param slcells selected cell types
##' @param xtitle a character representing the title of x axis
##' @param axistext.x a Boolean value that represents whether x-axis text is displayed
##' @param bar_width the width of the bar
##' @param flow a Boolean value representing whether it is presented as Alluvial Plots,
##' default value is TRUE
##' @param geomtext a Boolean value representing whether Annotate value,
##' default value is TRUE
##' @param color a vector containing a set of aesthetic values
##' @return a bar chart representing cell types proportion
##' @import ggplot2
##' @importFrom reshape2 melt
##' @examples
##' set.seed(1)
##' cdata <- matrix(sample(100:300, 25, replace = TRUE), 5, 5)
##' row.names(cdata) <- paste0("A",1:5)
##' colnames(cdata) <- c("B.cells.naive", "B.cells.memory", "Plasma.cells",
##' "T.cells.CD8", "T.cells.CD4.naive")
##' slcells <- c("B.cells.naive", "B.cells.memory", "Plasma.cells")
##' plotProp(cdata = cdata, slcells = slcells, xtitle = "Sample",
##' axistext.x = TRUE, bar_width = 0.5, flow = TRUE, geomtext = TRUE,
##' color = c("#00468BFF", "#925E9FFF", "#AD002AFF", "#FDAF91FF"))
##' @export
##' @author W Xie

plotProp <- function(cdata,
                     slcells = colnames(cdata),
                     xtitle = "Sample",
                     axistext.x = TRUE,
                     bar_width = 0.5,
                     flow = TRUE,
                     geomtext = TRUE,
                     color = NULL){
  if(axistext.x == TRUE){
    et <- ggplot2::element_text(size = 13, angle = 60,
                       hjust = 0.5, margin = ggplot2::margin(t = 0))
  }else{
    et <- ggplot2::element_blank()
  }
  dat <- as.matrix(cdata[, slcells])
  dat <- proportions(dat, margin = 1)
  dat <- as.data.frame(dat)
  dat[xtitle] <- row.names(dat)
  dat <- reshape2::melt(dat, id.vars = xtitle,
                        variable.name = "CellType",
                        value.name = "Proportion")

  if(is.null(color)){
    if (geomtext){
      if (flow){
        p <- plot.flow(dat = dat, xtitle = xtitle,
                       et = et, bar_width = bar_width)
        p <- p + ggplot2::geom_text(ggplot2::aes(label = round(Proportion, 3)), size = 3,
                           hjust = 0.5, vjust = 1.5, position = "stack")
      }else{
        p <- plot.bar(dat = dat, xtitle = xtitle,
                      et = et, bar_width = bar_width)
        p <- p + ggplot2::geom_text(ggplot2::aes(label = round(Proportion, 3)), size = 3,
                           hjust = 0.5, vjust = 1.5, position = "stack")
      }

    }else{
      if(flow){
        p <- plot.flow(dat = dat, xtitle = xtitle,
                       et = et, bar_width = bar_width)
      }else{
        p <- plot.bar(dat = dat, xtitle = xtitle,
                      et = et, bar_width = bar_width)
      }
    }
  }else{
    if (geomtext){
      if (flow){
        p <- plot.flow(dat = dat, xtitle = xtitle,
                       et = et, bar_width = bar_width)
        p <- p + ggplot2::scale_fill_manual(values = color)
        p <- p + ggplot2::geom_text(ggplot2::aes(label = round(Proportion, 3)), size = 3,
                           hjust = 0.5, vjust = 1.5, position = "stack")
      }else{
        p <- plot.bar(dat = dat, xtitle = xtitle,
                      et = et, bar_width = bar_width)
        p <- p + ggplot2::scale_fill_manual(values = color)
        p <- p + ggplot2::geom_text(ggplot2::aes(label = round(Proportion, 3)), size = 3,
                           hjust = 0.5, vjust = 1.5, position = "stack")
      }

    }else{
      if(flow){
        p <- plot.flow(dat = dat, xtitle = xtitle,
                       et = et, bar_width = bar_width)
        p <- p + ggplot2::scale_fill_manual(values = color)
      }else{
        p <- plot.bar(dat = dat, xtitle = xtitle,
                      et = et, bar_width = bar_width)
        p <- p + ggplot2::scale_fill_manual(values = color)
      }
    }
  }
  return(p)
}

##' Bar Plots
##' @title plot.bar
##' @param dat a dataframe containing three columns: xtitle(self-defined), CellType, Proportion
##' @param xtitle A custom column name, which is also the title name of the X-axis
##' @param et element_text
##' @param bar_width the width of the bar
##' @return a bar chart
##' @import ggplot2
##' @importFrom cowplot theme_map
##' @author W Xie

plot.bar <- function(dat = dat, xtitle = xtitle,
                     et = et, bar_width = bar_width){
  pc <- ggplot2::ggplot(dat,
                        ggplot2::aes_string(x = xtitle, y= "Proportion", fill = "CellType")) +
    ggplot2::geom_col(width = bar_width, position = "fill") +
    cowplot::theme_map() +
    ggplot2::theme(axis.text.x = et,
          axis.text.y = ggplot2::element_text(size = 13,
                        angle = 90, hjust = 0.5, margin = ggplot2::margin(r = 0)),
          axis.title.x = ggplot2::element_text(size = 20,
                        face = "bold", margin = ggplot2::margin(t = 15)),
          axis.title.y = ggplot2::element_text(size = 20, angle = 90,
                        face = "bold", margin = ggplot2::margin(r = 15))
          ) +
  return(pc)
}

##' Alluvial Plots
##' @title plot.flow
##' @param dat a dataframe containing three columns: xtitle(self-defined), CellType, Proportion
##' @param xtitle A custom column name, which is also the title name of the X-axis
##' @param et element_text
##' @param bar_width the width of the bar
##' @return a bar chart
##' @import ggplot2
##' @importFrom cowplot theme_map
##' @importFrom ggalluvial geom_flow
##' @author W Xie

plot.flow <- function(dat = dat, xtitle = xtitle,
                      et = et, bar_width = bar_width){
  pc <- ggplot2::ggplot(dat,
                        ggplot2::aes_string(x = xtitle, y= "Proportion", fill = "CellType",
                                   stratum = "CellType", alluvium = "CellType")) +
    ggplot2::geom_col(width = bar_width, position = "fill") +
    ggalluvial::geom_flow(width = 0.4, alpha = 0.2, knot.pos=0) +
    cowplot::theme_map() +
    ggplot2::theme(axis.text.x = et,
                   axis.text.y = ggplot2::element_text(size = 13,
                                 angle = 90, hjust = 0.5, margin = ggplot2::margin(r = 0)),
                   axis.title.x = ggplot2::element_text(size = 20,
                                 face = "bold", margin = ggplot2::margin(t = 15)),
                   axis.title.y = ggplot2::element_text(size = 20, angle = 90,
                                 face = "bold", margin = ggplot2::margin(r = 15)))
  return(pc)
}


