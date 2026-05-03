#' Load scRNA Dataset
#'
#' @description Loads the actual 10X Genomics PBMC dataset and assigns it an S3 class 
#'   called `scData` so we can easily use Object-Oriented methods on it.
#'   Single-cell RNA sequencing (scRNA-seq) lets us observe gene expression in individual cells.
#' @return An object of class `scData`, packing the sparse expression, PCA, and cell labels.
#' @export
#' @examples
#' data <- load_scrna()
#' print(data)
load_scrna <- function() {
  # We construct a new environment to load the lazy data correctly. 
  # This prevents global environment pollution.
  env <- new.env()
  utils::data("pbmc_data", package = "scExploreRFinal", envir = env)
  obj <- env$pbmc_data
  
  # By setting the class to "scData", R knows to route generic functions 
  # like print() and plot() to our specifically tailored logic below.
  class(obj) <- c("scData", "list")
  return(obj)
}

#' Print method for scData
#'
#' @description Briefly summarizes the matrix dimensions.
#' @param x An object of class `scData`
#' @param ... Additional arguments
#' @export
print.scData <- function(x, ...) {
  cat("scExploreRFinal Single-Cell Data Object\n")
  cat("----------------------------------\n")
  # Cells represent the statistical N (sample size).
  cat("Cells (N):", ncol(x$expression), "\n")
  # Genes represent the variables evaluated for each cell.
  cat("Genes (Variables):", nrow(x$expression), "\n")
  cat("Cell Types Available:", paste(levels(x$cell_types), collapse = ", "), "\n")
}

#' Summary method for scData
#'
#' @description Computes library sizes (total gene counts per cell) and population counts.
#' @param object An object of class `scData`
#' @param ... Additional arguments
#' @export
summary.scData <- function(object, ...) {
  cat("Summary of scExploreRFinal Object:\n")
  cat("\nCell Type Distribution:\n")
  # A simple frequency table showing how the total cell population is segmented.
  print(table(object$cell_types))
  
  # Library size refers to how much total genetic material was sequenced from each cell. 
  # We sum all gene expressions for each respective column (cell).
  expr_sums <- apply(object$expression, 2, sum)
  cat("\nLibrary Size (Total Expression per Cell):\n")
  cat("  Min:   ", min(expr_sums), "\n")
  cat("  Mean:  ", mean(expr_sums), "\n")
  cat("  Max:   ", max(expr_sums), "\n")
}

#' Plot method for scData
#'
#' @description A generic plot wrapper that defaults to PCA visualization to show biological clustering.
#' @param x An object of class `scData`
#' @param ... Additional arguments passed to `plot_pca`
#' @export
plot.scData <- function(x, ...) {
  cat("Plotting Principal Components to reveal cell clusters...\n")
  plot_pca(x, ...)
}
