#Blogger Link: 

# STEP 1: Exploring the iris dataset
# ===============================

data("iris")

head(iris, 6)
str(iris)
class(iris)
typeof(iris)
isS4(iris)

summary(iris)
plot(iris)

methods("summary")
methods("plot")



# S3 EXAMPLE 1: The flower_data class
# ===============================

flower_data <- function(df) {
  stopifnot(is.data.frame(df))
  structure(
    list(data = df),
    class = "flower_data"
  )
}

print.flower_data <- function(x, ...) {
  cat("Flower dataset\n")
  cat("Number of observations:", nrow(x$data), "\n")
  cat("Species levels:\n")
  print(unique(x$data$Species))
  invisible(x)
}

avg_sepal <- function(x, ...) UseMethod("avg_sepal")

avg_sepal.flower_data <- function(x, ...) {
  mean(x$data$Sepal.Length)
}

fd <- flower_data(iris)
fd
avg_sepal(fd)
class(fd)
isS4(fd)
typeof(fd)



# S3 EXAMPLE 2: Simple student class
# ===============================

student_s3 <- function(name, age, gpa) {
  x <- list(name = name, age = age, GPA = gpa)
  class(x) <- "student"
  x
}

print.student <- function(x, ...) {
  cat("Student:", x$name, "\nGPA:", x$GPA, "\n")
}

s3 <- student_s3("Myself", 29, 3.5)
s3



# S4 EXAMPLE 1: FlowerData class
# ===============================

setClass(
  "FlowerData",
  slots = list(
    data = "data.frame"
  )
)

setMethod(
  "show",
  "FlowerData",
  function(object) {
    cat("FlowerData object\n")
    cat("Rows:", nrow(object@data), "\n")
    cat("Species:", unique(object@data$Species), "\n")
  }
)

flower_s4 <- new("FlowerData", data = iris)
flower_s4
isS4(flower_s4)
slotNames(flower_s4)
flower_s4@data[1:3, ]



# S4 EXAMPLE 2: Student class with validation
# ===============================

setClass(
  "Student",
  slots = list(
    name = "character",
    age  = "numeric",
    GPA  = "numeric"
  ),
  validity = function(object) {
    if (object@GPA < 0 || object@GPA > 4)
      return("GPA must be between 0 and 4")
    TRUE
  }
)

setMethod(
  "show",
  "Student",
  function(object) {
    cat("Student:", object@name, "\n")
    cat("Age:", object@age, "\n")
    cat("GPA:", object@GPA, "\n")
  }
)

s4 <- new("Student", name="Myself", age=29, GPA=3.5)
s4
isS4(s4)
slotNames(s4)
