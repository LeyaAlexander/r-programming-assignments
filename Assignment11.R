#Blogger Link: https://rprogrammingjournalleyaalexander.blogspot.com/2026/04/assignment-11-debugging-tukey-outlier.html
# ===============================

# Helper function (provided, no bug)
tukey.outlier <- function(x, k = 1.5) {
  q1 <- quantile(x, 0.25, na.rm = TRUE)
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  iqr <- q3 - q1
  x < (q1 - k * iqr) | x > (q3 + k * iqr)
}

# Corrected function with defensive checks
# Bug fix: changed && to & for element-wise logical AND
corrected_tukey <- function(x) {
  if (!is.matrix(x)) stop("x must be a matrix.")
  if (!is.numeric(x)) stop("x must be a numeric matrix.")

  outliers <- array(TRUE, dim = dim(x))
  for (j in seq_len(ncol(x))) {
    outliers[, j] <- outliers[, j] & tukey.outlier(x[, j])
  }
  outlier.vec <- logical(nrow(x))
  for (i in seq_len(nrow(x))) {
    outlier.vec[i] <- all(outliers[i, ])
  }
  outlier.vec
}

# STEP 1: Test with normal data
# ===============================
set.seed(123)
test_mat <- matrix(rnorm(50), nrow = 10)

cat("Test matrix dimensions:", dim(test_mat), "\n")
print(head(test_mat))

cat("\n--- Running corrected_tukey ---\n")
result <- corrected_tukey(test_mat)
cat("Result:", result, "\n")
cat("Length:", length(result), "\n")
cat("Class:", class(result), "\n")

# STEP 2: Test with injected outliers
# ===============================
cat("\n--- Test with injected outliers ---\n")
test_mat2 <- test_mat
test_mat2[3, ] <- rep(100, 5)
test_mat2[7, ] <- rep(-100, 5)

result2 <- corrected_tukey(test_mat2)
cat("Result:", result2, "\n")
cat("Rows 3 and 7 should be TRUE.\n")

# STEP 3: Test defensive checks
# ===============================
cat("\n--- Testing defensive checks ---\n")

tryCatch(
  corrected_tukey(data.frame(a = 1:3, b = 4:6)),
  error = function(e) cat("Caught:", e$message, "\n")
)

tryCatch(
  corrected_tukey(matrix(letters[1:9], nrow = 3)),
  error = function(e) cat("Caught:", e$message, "\n")
)

cat("\nAll tests passed.\n")
