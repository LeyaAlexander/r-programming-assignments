# ============================================================
# Assignment 9: Visualization in R - Base Graphics, Lattice,
#               and ggplot2
# Dataset: SmallCellLung - Small Cell Lung Cancer Clinical Trial
# Source:  Rdatasets collection
#          https://vincentarelbundock.github.io/Rdatasets/datasets.html
#          Package: KMsurv | Dataset: smallcell
# Columns: treatment (A/B), age (years), survival (days)
# ============================================================

# ---- Load Dataset -------------------------------------------
SmallCellLung <- read.csv("SmallCellLung_tbl_df.csv")
head(SmallCellLung)
str(SmallCellLung)

# Convert treatment to factor for cleaner grouping
SmallCellLung$treatment <- as.factor(SmallCellLung$treatment)

# Create output folder for saved plots
dir.create("plots", showWarnings = FALSE)


# ============================================================
# SECTION 1: BASE R GRAPHICS
# ============================================================

# --- Plot 1: Scatter plot – Age vs Survival by Treatment ----
png("plots/base_scatter.png", width = 800, height = 600, res = 120)
plot_colors <- ifelse(SmallCellLung$treatment == "A", "tomato", "steelblue")

plot(SmallCellLung$age, SmallCellLung$survival,
     col  = plot_colors,
     pch  = 16,
     main = "Base R: Age vs. Survival by Treatment Group",
     xlab = "Age (years)",
     ylab = "Survival (days)")

legend("topright",
       legend = c("Treatment A", "Treatment B"),
       col    = c("tomato", "steelblue"),
       pch    = 16,
       bty    = "n")
dev.off()


# --- Plot 2: Histogram – Distribution of Survival Days ------
png("plots/base_histogram.png", width = 800, height = 600, res = 120)
hist(SmallCellLung$survival,
     col    = "lightblue",
     border = "white",
     breaks = 15,
     main   = "Base R: Distribution of Survival Days",
     xlab   = "Survival (days)",
     ylab   = "Frequency")

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
dev.off()


# ============================================================
# SECTION 2: LATTICE GRAPHICS
# ============================================================

library(lattice)

# --- Plot 3: Conditioned Scatter Plot – Survival ~ Age by Treatment ---
png("plots/lattice_xyplot.png", width = 900, height = 500, res = 120)
print(
  xyplot(survival ~ age | treatment,
         data   = SmallCellLung,
         pch    = 16,
         col    = "steelblue",
         main   = "Lattice: Survival vs. Age Conditioned by Treatment",
         xlab   = "Age (years)",
         ylab   = "Survival (days)",
         layout = c(2, 1))
)
dev.off()


# --- Plot 4: Box-and-Whisker Plot – Survival by Treatment ----
png("plots/lattice_boxplot.png", width = 700, height = 600, res = 120)
print(
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
)
dev.off()


# ============================================================
# SECTION 3: GGPLOT2
# ============================================================

library(ggplot2)

# --- Plot 5: Scatter Plot with Linear Smoother by Treatment --
p5 <- ggplot(SmallCellLung, aes(x = age, y = survival, color = treatment)) +
  geom_point(size = 2.5, alpha = 0.75) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 1) +
  scale_color_manual(values = c("A" = "tomato", "B" = "steelblue"),
                     labels  = c("Treatment A", "Treatment B")) +
  labs(title    = "ggplot2: Age vs. Survival with Linear Trend by Treatment",
       x        = "Age (years)",
       y        = "Survival (days)",
       color    = "Treatment") +
  theme_minimal(base_size = 13)
ggsave("plots/ggplot2_scatter.png", plot = p5, width = 8, height = 5, dpi = 150)


# --- Plot 6: Faceted Histogram – Survival Distribution by Treatment ---
p6 <- ggplot(SmallCellLung, aes(x = survival, fill = treatment)) +
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
ggsave("plots/ggplot2_histogram.png", plot = p6, width = 8, height = 5, dpi = 150)

cat("\nAll 6 plots saved to the plots/ folder.\n")
