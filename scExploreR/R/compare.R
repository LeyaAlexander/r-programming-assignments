#' Compare Gene Expression Between Two Cell Types
#'
#' Perform a t-test or Wilcoxon rank-sum test to compare gene expression.
#'
#' @param data An scrna_data object
#' @param gene Character. Gene symbol to compare.
#' @param group1 Character. First cell type.
#' @param group2 Character. Second cell type.
#' @param method Character. "t.test" (default) or "wilcox".
#' @return A list with test results
#' @export
compare_expression <- function(data, gene, group1, group2, method = "t.test") {
  # TODO: implement
}

#' One-Way ANOVA for Gene Expression
#'
#' Test whether a gene's expression differs across multiple cell types.
#'
#' @param data An scrna_data object
#' @param gene Character. Gene symbol to test.
#' @return A list with F-statistic, p-value, and group means
#' @export
run_anova <- function(data, gene) {
  # TODO: implement
}
