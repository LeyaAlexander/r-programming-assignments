data <- load_scrna()
valid_gene <- rownames(data$expression)[1]

# ── plot_pca ─────────────────────────────────────────────────────────────────

test_that("plot_pca with ggplot2 method returns a ggplot object", {
  result <- plot_pca(data, method = "ggplot2")
  expect_s3_class(result, "ggplot")
})

test_that("plot_pca with lattice method returns a trellis object", {
  result <- plot_pca(data, method = "lattice")
  expect_s3_class(result, "trellis")
})

test_that("plot_pca with base method returns NULL invisibly", {
  result <- plot_pca(data, method = "base")
  expect_null(result)
})

test_that("plot_pca errors on wrong data class", {
  expect_error(plot_pca(list()), "scData")
})

test_that("plot_pca errors when pca slot is missing or not a data frame", {
  bad <- data
  bad$pca <- NULL
  expect_error(plot_pca(bad), "data\\$pca must be a data frame")
})

# ── plot_expression ───────────────────────────────────────────────────────────

test_that("plot_expression with ggplot2 method returns a ggplot object", {
  result <- plot_expression(data, valid_gene, method = "ggplot2")
  expect_s3_class(result, "ggplot")
})

test_that("plot_expression with lattice method returns a trellis object", {
  result <- plot_expression(data, valid_gene, method = "lattice")
  expect_s3_class(result, "trellis")
})

test_that("plot_expression with base method returns NULL invisibly", {
  result <- plot_expression(data, valid_gene, method = "base")
  expect_null(result)
})

test_that("plot_expression errors on wrong data class", {
  expect_error(plot_expression(list(), valid_gene), "scData")
})

test_that("plot_expression errors when gene is not a single string", {
  expect_error(plot_expression(data, 99), "single character string")
  expect_error(plot_expression(data, c("A", "B")), "single character string")
})

test_that("plot_expression errors when gene is not in dataset", {
  expect_error(plot_expression(data, "FAKEGENE999"), "not found")
})
