# Task 5 — Repeat task 1 with PCA-reduced features
# Function only: no analysis or plots here, so it is safe to source.
# Takes the PCA fitted in code/task5/pca.R and a number of components k,
# projects the features onto the first k components, and calls pair_sims() from code/task1/pairs.R
# to return pairs_left and pairs_right with the same pairs and labels as task 1.
# Used in code/task5/pca.R to calculate AUC against k.

source("code/task1/pairs.R")
