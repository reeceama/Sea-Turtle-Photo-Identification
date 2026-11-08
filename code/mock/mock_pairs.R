# MOCK DATA — for testing code structure only.
# You do NOT need to wait for task 1 to be finished: build and test your code against these mock pairs now,
# then swap to the real pairs with one line when they are ready.
# NEVER use this in the final analysis, figures, tables or report.
# Nothing in code/analysis.R may source this file.
#
# Same columns and imbalance as the real pairs from code/task1/pairs.R
# (2,641 pairs per side, 40 matches), so code written against it works unchanged.
# When the real pairs are ready, replace source("code/mock/mock_pairs.R") with source("code/task1/pairs.R").

set.seed(1)

mock_pairs <- function(match_mean = 0.6, other_mean = 0.3, sd = 0.1) {
  data.frame(
    img1 = paste0("a", 1:2641),
    img2 = paste0("b", 1:2641),
    id1  = NA,
    id2  = NA,
    same = c(rep(1, 40), rep(0, 2601)),
    sim  = c(rnorm(40, match_mean, sd), rnorm(2601, other_mean, sd))
  )
}

pairs_left  <- mock_pairs()
pairs_right <- mock_pairs()

# For a harder, more overlapping case, try e.g. mock_pairs(match_mean = 0.5)
