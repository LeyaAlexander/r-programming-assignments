#' Public Single-Cell PBMC Dataset
#'
#' A subset of the authentic 10X Genomics Peripheral Blood Mononuclear Cells (PBMC) dataset. 
#' It contains 500 cells and 100 key genes to remain lightweight.
#'
#' @format A list with three components:
#' \describe{
#'   \item{expression}{Matrix of log-normalized sequences (genes x cells).}
#'   \item{pca}{Data frame housing reduced Principal Component Analysis mapping.}
#'   \item{cell_types}{Derived categorizations indicating the specific biological identity of each cell.}
#' }
#' 
#' @source Curated directly from public 10x Genomics open datasets.
"pbmc_data"
