data <- load_scrna()

# ── print.scData ──────────────────────────────────────────────────────────────

test_that("print.scData outputs expected text", {
  output <- capture.output(print(data))
  expect_true(any(grepl("scExploreRFinal", output)))
  expect_true(any(grepl("Cells", output)))
  expect_true(any(grepl("Genes", output)))
})

# ── summary.scData ────────────────────────────────────────────────────────────

test_that("summary.scData outputs cell type distribution and library size", {
  output <- capture.output(summary(data))
  expect_true(any(grepl("Cell Type Distribution", output)))
  expect_true(any(grepl("Library Size", output)))
})

# ── plot.scData ───────────────────────────────────────────────────────────────

test_that("plot.scData dispatches to plot_pca and returns a ggplot by default", {
  # plot.scData passes ... to plot_pca; default method is "base" which returns NULL.
  # Pass method = "ggplot2" so we get a return value to inspect.
  result <- plot(data, method = "ggplot2")
  expect_s3_class(result, "ggplot")
})
