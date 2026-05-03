#' Explore Gene Expression Statistics
#'
#' @description Computes plain descriptive statistics (mean, median, standard deviation)
#'   for a specific gene distributed across all identified cell populations.
#' @param data An object of class `scData`.
#' @param gene A character string specifying the gene to explore.
#' @return A data frame with summary statistics per cell type.
#' @export
#' @examples
#' data <- load_scrna()
#' explore_genes(data, "CD79A")
explore_genes <- function(data, gene) {
  if (!inherits(data, "scData")) stop("data must be of class 'scData'")
  if (!gene %in% rownames(data$expression)) stop(paste("Gene", gene, "not found in dataset."))
  
  # Extract the single vector of scalar values representing this gene across all cells
  expr_vals <- data$expression[gene, ]
  types <- data$cell_types
  
  # aggregate() splits the data into groups by cell type, then calculates the statistics.
  # This reveals if the gene is evenly spread or specifically activated (expressed) in certain cells.
  stats <- stats::aggregate(expr_vals ~ types, FUN = function(x) {
    c(Mean = mean(x), Median = stats::median(x), SD = stats::sd(x))
  })
  
  # Format it clearly for reading
  out <- data.frame(
    CellType = stats$types,
    Mean = stats$expr_vals[, "Mean"],
    Median = stats$expr_vals[, "Median"],
    SD = stats$expr_vals[, "SD"]
  )
  
  return(out)
}

#' Compare Expression Between Two Cell Types
#'
#' @description Performs a two-sample t-test or Wilcoxon test to mathematically determine 
#'   if a gene is "differentially expressed" (significantly altered) between two cell types.
#' @param data An object of class `scData`.
#' @param gene A character string for the gene to test.
#' @param type1 The first cell type group.
#' @param type2 The second cell type group.
#' @param method The statistical test ("t.test" or "wilcox"). Default is "t.test".
#' @return An object of class `htest` containing the formal test results and p-value.
#' @export
#' @examples
#' data <- load_scrna()
#' compare_expression(data, "CD79A", "B cell", "CD4+ T cell")
compare_expression <- function(data, gene, type1, type2, method = "t.test") {
  if (!inherits(data, "scData")) stop("data must be of class 'scData'")
  if (!gene %in% rownames(data$expression)) stop("Gene not found.")
  if (!all(c(type1, type2) %in% levels(data$cell_types))) stop("Cell type not found.")
  
  # Grab data only for the selected two clusters 
  idx <- data$cell_types %in% c(type1, type2)
  group_expr <- data$expression[gene, idx]
  group_types <- droplevels(data$cell_types[idx])
  
  # The t-test assumes normality, whereas Wilcoxon is non-parametric. 
  # Single-cell data is often highly skewed (many zeros), making Wilcoxon popular in scRNA-seq.
  if (method == "t.test") {
    res <- stats::t.test(group_expr ~ group_types)
  } else if (method == "wilcox") {
    res <- stats::wilcox.test(group_expr ~ group_types)
  } else {
    stop("Method must be 't.test' or 'wilcox'.")
  }
  
  return(res)
}

#' Run One-Way ANOVA on Marker Genes
#'
#' @description Implements a One-Way ANOVA to test if the mean expression of a gene is 
#'   statistically identical across all cell types simultaneously, or if at least one cluster differs.
#' @param data An object of class `scData`.
#' @param gene A character string specifying the gene to test.
#' @return An object of class `aov`.
#' @export
#' @examples
#' data <- load_scrna()
#' run_anova(data, "CD8A")
run_anova <- function(data, gene) {
  if (!inherits(data, "scData")) stop("data must be of class 'scData'")
  if (!gene %in% rownames(data$expression)) stop("Gene not found.")
  
  # Build a 2-column dataframe connecting expression variables to categorical grouping factors
  df <- data.frame(Expression = data$expression[gene, ], CellType = data$cell_types)
  
  # The Analysis of Variance (aov) evaluates global variation. 
  # A low p-value suggests the gene is a distinct biological marker for at least one cell type.
  res <- stats::aov(Expression ~ CellType, data = df)
  
  return(res)
}
