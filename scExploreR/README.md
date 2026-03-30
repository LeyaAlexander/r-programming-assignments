# scExploreR 🧬

> Single-Cell RNA-Seq Explorer with UMAP Visualization

An educational R package connecting introductory statistics to single-cell
RNA-seq analysis. Demonstrates **three R plotting systems**: Base Graphics,
Lattice, and ggplot2.

## Installation

```r
# From local source
devtools::install_local("path/to/scExploreR")
```

## Quick Start

```r
library(scExploreR)

# Load bundled PBMC dataset (500 cells × 200 genes, 7 cell types)
data("pbmc_data")
scrna <- load_scrna()

# ── Descriptive Statistics ──
explore_genes(scrna, genes = c("CD3D", "MS4A1", "LYZ"))

# ── UMAP: pick your plotting system ──
plot_umap(scrna, method = "base")       # Base R Graphics
plot_umap(scrna, method = "lattice")    # Lattice
plot_umap(scrna, method = "ggplot2")    # ggplot2

# Color UMAP by gene expression
plot_umap(scrna, color_by = "CD3D", method = "ggplot2")

# ── Expression distributions ──
plot_expression(scrna, gene = "LYZ", method = "base")
plot_expression(scrna, gene = "LYZ", method = "lattice")
plot_expression(scrna, gene = "LYZ", method = "ggplot2")

# ── Hypothesis Testing ──
compare_expression(scrna, gene = "CD3D",
                   group1 = "CD4+ T cell", group2 = "B cell")
run_anova(scrna, gene = "LYZ")
```

## Functions (6 total)

| Function | Purpose | Stats Concept |
|----------|---------|---------------|
| `load_scrna()` | Load .rda data | Data import |
| `explore_genes()` | Descriptive stats | mean, sd, var |
| `compare_expression()` | Two-group test | t.test / wilcox |
| `run_anova()` | Multi-group test | aov (F-test) |
| `plot_umap()` | UMAP scatter plot | Visualization |
| `plot_expression()` | Box/violin plots | Visualization |

## Dependencies

Only `ggplot2` and `lattice` (+ base R). No Bioconductor required.

## License

MIT
