# Create the matrices
A <- matrix(1:100,  nrow = 10)     # 10x10
B <- matrix(1:1000, nrow = 10)     # 10x100

# Check dimensions
dim(A)
dim(B)

# Determinant of A (only defined for square matrices)
detA <- det(A)
detA

# Attempt inverse of A (will fail because det(A) = 0)
try(solve(A))

# Attempt determinant/inverse of B (will fail because B is not square)
try(det(B))
try(solve(B))


# Extra steps (as recommended)

# Transpose (flips rows/columns)
A_t <- t(A)
B_t <- t(B)

dim(A_t)
dim(B_t)

# Multiply matrix by a vector
v <- 1:10
A_multiplied <- A %*% v
dim(A_multiplied)
A_multiplied

# Multiply two matrices
C <- A %*% B
dim(C)
C[1:5, 1:5]   # just a small corner 
