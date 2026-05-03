# scExploreR 🧬

**scExploreR** is an educational toolkit for exploring single-cell RNA sequencing (scRNA-seq) data. It is constructed to safely encapsulate complex genomics inside straightforward R paradigms. 

## About the Author & Context
I am an undergraduate pre-med student at the **University of South Florida (USF)**. This package was developed for **LIS4370, Advanced R Programming**, taught by Dr. Alon Friedman in the School of Information within the **College of Arts and Sciences**.

To fulfill research experience requirements for medical school admissions, I am currently working in the Machine Learning Department at **Moffitt Cancer Center** in the **El Naqa Lab**, where I am conducting a case study on **clear cell renal cell carcinoma (ccRCC)**. 

*Project Inspiration:* My exposure to complex genomics and spatial transcriptomics during my research experience deeply inspired me to formulate this idea. Note that this R package is an independent educational tool, not an official product of the El Naqa Lab. It was created solely for my Advanced R Programming final project as a programmatic exploration of the foundational statistical routines underlying scRNA-seq analysis.

## Overview of Features

- **S3 Object-Oriented Framework**: Wraps sparse matrices inside a custom `scData` class (with automatic `print`, `summary`, and `plot` dispatches).
- **Multiple Plotting Systems**: Render identical PCA charts using Base Graphics, `lattice`, and `ggplot2`.
- **Integrated Statistical Testing**: Built-in wrappers implementing Descriptives, Two-Sample t-tests, standard Wilcoxon rank-sum, and generalized one-way ANOVA.
- **Authentic Dataset**: Lazily loads an authentic subset (500 cells, 100 key genes) curated directly from the standard **"3k PBMCs from a Healthy Donor"** public dataset. 
  - *Data Citation:* 10x Genomics. (2016). *3k PBMCs from a Healthy Donor* [Data set]. Single Cell Gene Expression Dataset. Available at: [10x Genomics Support](https://support.10xgenomics.com/single-cell-gene-expression/datasets/1.1.0/pbmc3k)

## Usage Overview

```r
library(scExploreR)

# 1. Load the S3 matrix
obj <- load_scrna()

# 2. Automatically compute and display Principal Components
plot(obj, method = "ggplot2")

# 3. Perform T-Tests on cellular distributions
res <- compare_expression(obj, gene = "CD79A", type1 = "B cell", type2 = "CD4+ T cell")
print(res)
```

## AI Usage Statement
*(Self-Assessment: Mastery/Exceeds Criteria)*
To expedite the architectural boilerplate of this repository (directory setups, `roxygen2` header frameworks, S3 bindings, dataset curation), Generative AI (Google DeepMind) served as a programming assistant. However, package concepts, plotting transitions logic (Base vs Lattice vs ggplot), and plain-english contextual statistical tagging were reviewed, tested, and actively curated by the student author to reinforce course materials and meet syllabus criteria.
