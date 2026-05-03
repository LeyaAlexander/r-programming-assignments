# scExploreRFinal

**scExploreRFinal** is an educational R package for exploring single-cell RNA sequencing (scRNA-seq) data. It is the final-project version of the `scExploreR` package skeleton submitted for Assignment 10, extended with the defensive-programming patterns from Assignment 11 and the long-form documentation patterns from Assignment 12.

## About the Author & Context
I am an undergraduate pre-med student at the **University of South Florida (USF)**. This package was developed for **LIS4370, Advanced R Programming**, taught by Dr. Alon Friedman in the School of Information within the College of Arts and Sciences.

To fulfill research experience requirements for medical school admissions, I am currently working in the Machine Learning Department at **Moffitt Cancer Center** in the **El Naqa Lab**, where I am conducting a case study on clear cell renal cell carcinoma (ccRCC).

*Project Inspiration:* My exposure to complex genomics and spatial transcriptomics during my research experience inspired me to formulate this idea. This R package is an independent educational tool, not an official product of the El Naqa Lab. It was created solely for my Advanced R Programming final project as a programmatic exploration of the foundational statistical routines underlying scRNA-seq analysis.

## Installation

```r
# install.packages("devtools")
devtools::install_github(
  "LeyaAlexander/r-programming-assignments",
  subdir = "scExploreRFinal",
  build_vignettes = TRUE
)
```

## Overview of Features

- **S3 Object-Oriented Framework**: Wraps the sparse expression matrix inside a custom `scData` class with `print`, `summary`, and `plot` methods.
- **Multiple Plotting Systems**: Render identical PCA scatter and gene-expression boxplots using Base Graphics, `lattice`, and `ggplot2`.
- **Integrated Statistical Testing**: Wrappers for descriptive statistics, two-sample t-tests, Wilcoxon rank-sum, and one-way ANOVA over cell-type groups.
- **Defensive Input Validation**: Every public function checks class, type, and group membership before running, returning informative error messages instead of cryptic stack traces.
- **Authentic Dataset**: Lazily loads a subset (500 cells, 100 genes) curated from the **"3k PBMCs from a Healthy Donor"** public dataset.
  - *Data Citation:* 10x Genomics. (2016). *3k PBMCs from a Healthy Donor* \[Data set\]. Single Cell Gene Expression Dataset. Available at the [10x Genomics support site](https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k).

## Usage Overview

```r
library(scExploreRFinal)

# 1. Load the S3 object
obj <- load_scrna()

# 2. Visualize cell clusters via PCA in your preferred plotting system
plot(obj, method = "ggplot2")

# 3. Compare gene expression between two cell types
res <- compare_expression(obj, gene = "CD79A", type1 = "B cell", type2 = "CD4+ T cell")
print(res)
```

## License

CC0 1.0 Universal (Public Domain Dedication). See `LICENSE`.

## A note on the package name

`scExploreR` is also the name of an unrelated, separately-published Shiny platform from the El Naqa Lab and collaborators (bioRxiv 2025). This package was named independently for the LIS4370 final project and is **not affiliated with that platform**. To avoid confusion, the final-project version of the package is named `scExploreRFinal`.

## AI Usage Statement

Generative AI was used as a programming assistant during development. Specifically, Anthropic Claude (via the Cowork desktop app) helped with package scaffolding, roxygen2 header structure, S3 method bindings, defensive-programming refactors, and DESCRIPTION metadata review. All package design choices, statistical logic, plotting-system comparisons, and the choice of which 10x Genomics dataset to bundle were made by the student author and verified against course materials. AI-generated code was reviewed and tested before commit.
