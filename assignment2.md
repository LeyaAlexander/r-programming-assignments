# Assignment 2 – Evaluate myMean Function

## Blog Post

Link to blog post: https://rprogrammingjournalleyaalexander.blogspot.com/2026/01/assignment-2.html

## Test Result (Error)

Running:

myMean(assignment2)

Produces the error:

Error in myMean(assignment2) : object 'assignment' not found

## Test Result (Corrected Output)

After correcting the function, running:

myMean(assignment2)

Returns:

19.25

## Explanation

Inside the function, the parameter is named assignment2, but the code uses assignment and someData, which do not exist. R cannot find those objects, which is why we get the error. The variable names inside the function must match the argument names. 

## Corrected Function

```r
myMean <- function(assignment2) {
  sum(assignment2) / length(assignment2)
}
