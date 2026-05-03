data <- load_scrna()
valid_gene <- rownames(data$expression)[1]
valid_types <- levels(data$cell_types)

# ── explore_genes ────────────────────────────────────────────────────────────

test_that("explore_genes returns a data frame with expected columns", {
  result <- explore_genes(data, valid_gene)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("CellType", "Mean", "Median", "SD") %in% names(result)))
})

test_that("explore_genes returns one row per cell type", {
  result <- explore_genes(data, valid_gene)
  expect_equal(nrow(result), nlevels(data$cell_types))
})

test_that("explore_genes errors on wrong data class", {
  expect_error(explore_genes(list(), valid_gene), "scData")
})

test_that("explore_genes errors when gene is not a single string", {
  expect_error(explore_genes(data, 123), "single character string")
  expect_error(explore_genes(data, c("A", "B")), "single character string")
})

test_that("explore_genes errors when gene is not in dataset", {
  expect_error(explore_genes(data, "FAKEGENE999"), "not found")
})

# ── compare_expression ───────────────────────────────────────────────────────

test_that("compare_expression returns an htest (t.test default)", {
  result <- compare_expression(data, valid_gene, valid_types[1], valid_types[2])
  expect_s3_class(result, "htest")
})

test_that("compare_expression returns an htest with wilcox method", {
  result <- compare_expression(data, valid_gene, valid_types[1], valid_types[2],
                               method = "wilcox")
  expect_s3_class(result, "htest")
})

test_that("compare_expression errors on wrong data class", {
  expect_error(compare_expression(list(), valid_gene, valid_types[1], valid_types[2]),
               "scData")
})

test_that("compare_expression errors when gene is not a single string", {
  expect_error(compare_expression(data, 123, valid_types[1], valid_types[2]),
               "single character string")
})

test_that("compare_expression errors when cell type is not found", {
  expect_error(
    compare_expression(data, valid_gene, "NotACellType", valid_types[2]),
    "Cell type not found"
  )
})

test_that("compare_expression errors on invalid method", {
  expect_error(
    compare_expression(data, valid_gene, valid_types[1], valid_types[2],
                       method = "anova"),
    "Method must be"
  )
})

# ── run_anova ────────────────────────────────────────────────────────────────

test_that("run_anova returns an aov object", {
  result <- run_anova(data, valid_gene)
  expect_s3_class(result, "aov")
})

test_that("run_anova errors on wrong data class", {
  expect_error(run_anova(list(), valid_gene), "scData")
})

test_that("run_anova errors when gene is not a single string", {
  expect_error(run_anova(data, 42), "single character string")
})

test_that("run_anova errors when gene is not in dataset", {
  expect_error(run_anova(data, "FAKEGENE999"), "not found")
})
