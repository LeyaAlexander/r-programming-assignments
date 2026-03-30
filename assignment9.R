# ============================================================
# Assignment 9: Visualization in R - Base Graphics, Lattice,
#               and ggplot2
# Dataset: SmallCellLung - Small Cell Lung Cancer Clinical Trial
#          Columns: treatment (A/B), age (years), survival (days)
# ============================================================

# ---- Load Dataset -------------------------------------------
SmallCellLung <- read.csv("SmallCellLung_tbl_df.csv")
head(SmallCellLung)
str(SmallCellLung)

# Convert treatment to factor for cleaner grouping
SmallCellLung$treatment <- as.factor(SmallCellLung$treatment)


# ============================================================
# SECTION 1: BASE R GRAPHICS
# ============================================================

# --- Plot 1: Scatter plot – Age vs Survival by Treatment ----
# Color points by treatment group (A = tomato, B = steelblue)
plot_colors <- ifelse(SmallCellLung$treatment == "A", "tomato", "steelblue")

plot(SmallCellLung$age, SmallCellLung$survival,
     col  = plot_colors,
     pch  = 16,
     main = "Base R: Age vs. Survival by Treatment Group",
     xlab = "Age (years)",
     ylab = "Survival (days)")

# Add a legend so we know which color is which
legend("topright",
       legend = c("Treatment A", "Treatment B"),
       col    = c("tomato", "steelblue"),
       pch    = 16,
       bty    = "n")


# --- Plot 2: Histogram – Distribution of Survival Days ------
hist(SmallCellLung$survival,
     col    = "lightblue",
     border = "white",
     breaks = 15,
     main   = "Base R: Distribution of Survival Days",
     xlab   = "Survival (days)",
     ylab   = "Frequency")

# Add a vertical line for the median survival
abline(v   = median(SmallCellLung$survival),
       col = "tomato",
       lwd = 2,
       lty = 2)

legend("topright",
       legend = paste("Median =", median(SmallCellLung$survival), "days"),
       col    = "tomato",
       lty    = 2,
       lwd    = 2,
       bty    = "n")


# ============================================================
# SECTION 2: LATTICE GRAPHICS
# ============================================================

library(lattice)

# --- Plot 3: Conditioned Scatter Plot – Survival ~ Age by Treatment ---
xyplot(survival ~ age | treatment,
       data   = SmallCellLung,
       pch    = 16,
       col    = "steelblue",
       main   = "Lattice: Survival vs. Age Conditioned by Treatment",
       xlab   = "Age (years)",
       ylab   = "Survival (days)",
       layout = c(2, 1))   # side-by-side panels


# --- Plot 4: Box-and-Whisker Plot – Survival by Treatment ----
bwplot(survival ~ treatment,
       data  = SmallCellLung,
       main  = "Lattice: Survival Days by Treatment Group",
       xlab  = "Treatment Group",
       ylab  = "Survival (days)",
       par.settings = list(
         box.rectangle = list(col = "steelblue"),
         box.umbrella  = list(col = "steelblue"),
         plot.symbol   = list(col = "tomato", pch = 16)
       ))


# ============================================================
# SECTION 3: GGPLOT2
# ============================================================

library(ggplot2)

# --- Plot 5: Scatter Plot with Linear Smoother by Treatment --
ggplot(SmallCellLung, aes(x = age, y = survival, color = treatment)) +
  geom_point(size = 2.5, alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 1) +
  scale_color_manual(values = c("A" = "tomato", "B" = "steelblue"),
                     labels  = c("Treatment A", "Treatment B")) +
  labs(title    = "ggplot2: Age vs. Survival with Linear Trend by Treatment",
       x        = "Age (years)",
       y        = "Survival (days)",
       color    = "Treatment") +
  theme_minimal(base_size = 13)


# --- Plot 6: Faceted Histogram – Survival Distribution by Treatment ---
ggplot(SmallCellLung, aes(x = survival, fill = treatment)) +
  geom_histogram(binwidth = 150, color = "white", alpha = 0.85) +
  facet_wrap(~ treatment,
             labeller = labeller(treatment = c("A" = "Treatment A",
                                               "B" = "Treatment B"))) +
  scale_fill_manual(values = c("A" = "tomato", "B" = "steelblue")) +
  labs(title = "ggplot2: Distribution of Survival Days by Treatment Group",
       x     = "Survival (days)",
       y     = "Count") +
  theme_minimal(base_size = 13) +
  theme(legend.position = "none")
