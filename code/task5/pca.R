# Task 5 — PCA
# Rough exploratory work
# Apply PCA to the 1536-dimensional feature vectors. Plot the cumulative proportion of variance explained
# and find how many components explain 90% of the variance. Repeat task 1 with the PCA-reduced features,
# and see how the AUC changes with the number of components kept. Can the dimension be reduced a lot
# without losing much classification performance?
# Keep everything; move good work into code/analysis.R.
# Save outputs to outputs/task5/.

source("code/setup.R")
source("code/task1/pairs.R")
source("code/task2/pair_auc.R")
source("code/task5/pca_pairs.R")
