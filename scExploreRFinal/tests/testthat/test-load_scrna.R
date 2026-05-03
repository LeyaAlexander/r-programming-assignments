test_that("load_scrna returns an scData object", {
  data <- load_scrna()
  expect_s3_class(data, "scData")
})

test_that("load_scrna expression matrix has correct structure", {
  data <- load_scrna()
  expect_true(is.matrix(data$expression))
  expect_equal(ncol(data$expression), 500)   # 500 cells
  expect_equal(nrow(data$expression), 100)   # 100 genes
})

test_that("load_scrna cell_types is a factor with 6 levels", {
  data <- load_scrna()
  expect_true(is.factor(data$cell_types))
  expect_equal(nlevels(data$cell_types), 6)
  expect_equal(length(data$cell_types), 500)
})

test_that("load_scrna pca is a data frame with PC1 and PC2", {
  data <- load_scrna()
  expect_true(is.data.frame(data$pca))
  expect_true(all(c("PC1", "PC2") %in% names(data$pca)))
  expect_equal(nrow(data$pca), 500)
})
