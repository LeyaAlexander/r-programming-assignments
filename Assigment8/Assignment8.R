# =============================================================
# Mean by Sex, Filter Names with "i", and Export to CSV
# =============================================================

library(plyr)

# Read the dataset via file chooser
Student <- read.csv(file.choose(), header = TRUE)

# Step 1: Run the mean by Sex using ddply with transform
StudentAverage <- ddply(Student, "Sex", transform, Grade.Average = mean(Grade))
sex <- Student$Sex
mean(sex)

# Write the gendered mean data to a table file
write.table(StudentAverage, "Students_Gendered_Mean")

# Step 2: Filter the original dataset to include only students
# whose name contains the letter "i"
i_students <- subset(Student, grepl("i", Student$Name, ignore.case = TRUE))

# Step 3: Write the filtered dataset to a CSV file using file.choose()
write.csv(i_students, file = file.choose(new = TRUE), row.names = FALSE)
