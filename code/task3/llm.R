# Task 3 — LLM classifier
# Rough exploratory work
# Test an LLM as a classifier on left-left, different-year pairs:
# randomly sample a fixed number of pairs (preferably at least 20), keeping roughly the same proportion of
# matches as the full dataset; use exactly the same prompt for every pair; force a "same"/"different" answer;
# never reveal the identity labels.
# Keep everything; move good work into code/analysis.R.
# Save the prompt, sampled pairs and answers to outputs/task3/.

source("code/setup.R")
source("code/task1/pairs.R")
