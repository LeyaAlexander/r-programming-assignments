#' Plot PCA Emdeddings
#'
#' @description Maps the highly complex sequencing dimensions down to just 2 Principal Components (PC1 and PC2).
#'   Cells with similar transcriptomic profiles (similar biological identities) map closer together.
#' @param data An object of class `scData`.
#' @param method Plotting system to use: "base", "lattice", or "ggplot2".
#' @return A plot object or NULL.
#' @export
#' @examples
#' data <- load_scrna()
#' plot_pca(data, method = "ggplot2")
plot_pca <- function(data, method = c("base", "lattice", "ggplot2")) {
  if (!inherits(data, "scData")) stop("data must be of class 'scData'")
  method <- match.arg(method)
  
  pca_data <- data$pca
  pca_data$CellType <- data$cell_types
  
  if (method == "base") {
    # Base R assigns one color mapped to the index of the categorical factor
    palette <- grDevices::rainbow(nlevels(pca_data$CellType))
    colors <- palette[as.numeric(pca_data$CellType)]
    
    graphics::plot(pca_data$PC1, pca_data$PC2, 
         col = colors, pch = 16,
         main = "PCA Clustering (Base R)",
         xlab = "Principal Component 1", ylab = "Principal Component 2")
    
    graphics::legend("topright", legend = levels(pca_data$CellType), fill = palette, cex = 0.8)
    return(invisible(NULL))
    
  } else if (method == "lattice") {
    if (!requireNamespace("lattice", quietly = TRUE)) stop("lattice package is required.")
    
    # Lattice automatically separates factor levels using the 'groups' argument
    p <- lattice::xyplot(PC2 ~ PC1, groups = CellType, data = pca_data,
                         auto.key = list(space = "right", title = "Cell Type", cex.title = 1),
                         main = "PCA Clustering (Lattice)",
                         pch = 16)
    return(p)
    
  } else if (method == "ggplot2") {
    if (!requireNamespace("ggplot2", quietly = TRUE)) stop("ggplot2 package is required.")
    
    # ggplot2 maps 'color' aesthetics directly to the cell categories, producing a legend intrinsically
    p <- ggplot2::ggplot(pca_data, ggplot2::aes(x = PC1, y = PC2, color = CellType)) +
      ggplot2::geom_point(alpha = 0.8, size = 1.5) +
      ggplot2::theme_minimal() +
      ggplot2::labs(title = "PCA Clustering (ggplot2)", x = "Principal Component 1", y = "Principal Component 2")
    
    return(p)
  }
}

#' Plot Gene Expression Distribution
#'
#' @description Generates boxplots or violins depicting the statistical distribution (spread and median)
#'   of transcript counts for a specific targeting gene across different clusters.
#' @param data An object of class `scData`.
#' @param gene A character string specifying the gene.
#' @param method Plotting system to use.
#' @return A plot object or NULL.
#' @export
#' @examples
#' data <- load_scrna()
#' plot_expression(data, "CD4", method = "lattice")
plot_expression <- function(data, gene, method = c("base", "lattice", "ggplot2")) {
  if (!inherits(data, "scData")) stop("data must be of class 'scData'")
  if (!gene %in% rownames(data$expression)) stop("Gene not found.")
  method <- match.arg(method)
  
  df <- data.frame(
    Expression = data$expression[gene, ],
    CellType = data$cell_types
  )
  
  main_title <- paste("Expression of", gene)
  
  if (method == "base") {
    # Generate simple interquartile range (IQR) boxes
    palette <- grDevices::rainbow(nlevels(df$CellType))
    graphics::boxplot(Expression ~ CellType, data = df,
            col = palette,
            main = paste(main_title, "(Base R)"),
            ylab = "Log Normalized Expression", las = 2)
    return(invisible(NULL))
    
  } else if (method == "lattice") {
    # Lattice automatically arrays boxplots based on conditionals (Expression conditional on CellType)
    p <- lattice::bwplot(Expression ~ CellType, data = df,
                         main = paste(main_title, "(Lattice)"),
                         ylab = "Log Normalized Expression",
                         scales = list(x = list(rot = 45)))
    return(p)
    
  } else if (method == "ggplot2") {
    # ggplot2 overlays violins (giving kernel density/shape) on top of mini-boxplots
    p <- ggplot2::ggplot(df, ggplot2::aes(x = CellType, y = Expression, fill = CellType)) +
      ggplot2::geom_violin(alpha = 0.7, trim = FALSE) +
      ggplot2::geom_boxplot(width = 0.1, fill = "white", alpha = 0.5) +
      ggplot2::theme_minimal() +
      ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
      ggplot2::labs(title = paste(main_title, "(ggplot2)"), 
                    y = "Log Normalized Expression", x = "") +
      ggplot2::guides(fill = "none")
    
    return(p)
  }
}
