# Variables: freq, bloodp, first, second, finaldecision

Frequency <- c(0.6, 0.3, 0.4, 0.4, 0.2, 0.6, 0.3, 0.4, 0.9, 0.2)
BP        <- c(103, 87, 32, 42, 59, 109, 78, 205, 135, 176)

# first: bad = 1, good = 0, NA stays NA
FirstText <- c("bad","bad","bad","bad","good","good","good","good", NA, "bad")
First     <- ifelse(is.na(FirstText), NA, ifelse(FirstText == "bad", 1, 0))

# second: low = 0, high = 1
SecondText <- c("low","low","high","high","low","low","high","high","high","high")
Second     <- ifelse(SecondText == "high", 1, 0)

# finaldecision: low = 0, high = 1
FinalText <- c("low","high","low","high","low","high","low","high","high","high")
FinalDecision <- ifelse(FinalText == "high", 1, 0)

hospital <- data.frame(
  freq = Frequency,
  bloodp = BP,
  first = First,
  second = Second,
  finaldecision = FinalDecision
)

hospital


par(mfrow = c(1, 2))  # 1 row, 2 plots

boxplot(hospital$bloodp,
        main = "Boxplot of Blood Pressure",
        ylab = "BP")

hist(hospital$bloodp,
     main = "Histogram of Blood Pressure",
     xlab = "BP")


par(mfrow = c(1, 2))

boxplot(hospital$freq,
        main = "Boxplot of Visit Frequency",
        ylab = "Frequency")

hist(hospital$freq,
     main = "Histogram of Visit Frequency",
     xlab = "Frequency")
