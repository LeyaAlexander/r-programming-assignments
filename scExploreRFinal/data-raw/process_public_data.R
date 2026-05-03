# Read the standard 10X genomics MTX format using Matrix package
library(Matrix)

data_dir <- "data-raw/pbmc/filtered_gene_bc_matrices/hg19/"
mat <- readMM(paste0(data_dir, "matrix.mtx"))
genes <- read.delim(paste0(data_dir, "genes.tsv"), header = FALSE, stringsAsFactors = FALSE)
barcodes <- read.delim(paste0(data_dir, "barcodes.tsv"), header = FALSE, stringsAsFactors = FALSE)

rownames(mat) <- genes$V2
colnames(mat) <- barcodes$V1

# 1. Key biological markers
key_genes <- c("CD3D", "CD4", "CD8A", "MS4A1", "CD79A", "GNLY", "NKG7", "LYZ", "CST3")

# 2. Select top 500 cells with the highest library size
lib_size <- colSums(mat)
top_cells <- order(lib_size, decreasing = TRUE)[1:500]
mat_subset <- mat[, top_cells]

# 3. Select key genes + 91 highly variable genes (total 100 genes)
gene_vars <- apply(mat_subset, 1, var)
top_genes_idx <- order(gene_vars, decreasing = TRUE)[1:150]
selected_genes <- unique(c(which(rownames(mat) %in% key_genes), top_genes_idx))[1:100]

mat_final <- mat_subset[selected_genes, ]
mat_dense <- as.matrix(mat_final)

# Log Normalization
mat_norm <- log1p(sweep(mat_dense, 2, colSums(mat_dense), "/") * 10000)

# Cell Type Annotation Heuristic
assign_cell_type <- function(expr) {
  if (expr["CD79A"] > 0 | expr["MS4A1"] > 0) return("B cell")
  if (expr["LYZ"] > 0) return("Monocyte")
  if (expr["GNLY"] > 0 | expr["NKG7"] > 0) return("NK cell")
  if (expr["CD8A"] > 0) return("CD8+ T cell")
  if (expr["CD3D"] > 0 | expr["CD4"] > 0) return("CD4+ T cell")
  return("Other")
}

cell_types <- apply(mat_norm, 2, assign_cell_type)
cell_types <- factor(cell_types)

# Compute PCA for visualization
pca_res <- prcomp(t(mat_norm), rank. = 2)
pca_df <- data.frame(
  PC1 = pca_res$x[, 1],
  PC2 = pca_res$x[, 2]
)
rownames(pca_df) <- colnames(mat_norm)

pbmc_data <- list(
  expression = mat_norm,
  pca = pca_df,
  cell_types = cell_types
)

dir.create("data", showWarnings = FALSE)
save(pbmc_data, file = "data/pbmc_data.rda")
