# Task 4 — LLM vs threshold classifiers
# Rough exploratory work
# How does the LLM from task 3 perform compared with the threshold classifiers, on the same pairs?
# Keep everything; move good work into code/analysis.R.
# Save outputs to outputs/task4/.

source("code/setup.R")
source("code/task1/pairs.R")
classification_metrics <- function(truth, predicted) {
  stopifnot(
    length(truth) > 0,
    length(truth) == length(predicted),
    !anyNA(truth),
    !anyNA(predicted),
    all(truth %in% c(0, 1)),
    all(predicted %in% c(0, 1))
  )
  
  TP <- sum(truth == 1 & predicted == 1)
  TN <- sum(truth == 0 & predicted == 0)
  FP <- sum(truth == 0 & predicted == 1)
  FN <- sum(truth == 1 & predicted == 0)
  
  divide <- function(a, b) {
    if (b == 0) NA_real_ else a / b
  }
  
  sensitivity <- divide(TP, TP + FN)
  specificity <- divide(TN, TN + FP)
  
  data.frame(
    TP = TP,
    TN = TN,
    FP = FP,
    FN = FN,
    accuracy = divide(TP + TN, length(truth)),
    sensitivity = sensitivity,
    specificity = specificity,
    precision = divide(TP, TP + FP),
    F1 = divide(2 * TP, 2 * TP + FP + FN),
    balanced_accuracy = (sensitivity + specificity) / 2
  )
}
evaluate_llm <- function() {
  pairs <- read.csv(
    "outputs/task3/sampled_pairs.csv",
    stringsAsFactors = FALSE
  )
  
  answers <- read.csv(
    "outputs/task3/llm_answers.csv",
    stringsAsFactors = FALSE
  )
  
  if (
    anyNA(answers$pair_id) ||
    anyDuplicated(answers$pair_id) ||
    !setequal(pairs$pair_id, answers$pair_id)
  ) {
    stop("The answer sheet must contain each sampled pair exactly once.")
  }
  
  answers <- answers[
    match(pairs$pair_id, answers$pair_id),
  ]
  
  response <- trimws(answers$answer)
  
  if (anyNA(response) || any(response == "")) {
    stop("The answer sheet is not complete yet.")
  }
  
  valid <- response %in% c("same", "different")
  
  if (!any(valid)) {
    stop("There are no valid same/different responses to score.")
  }
  
  results <- classification_metrics(
    pairs$same[valid],
    as.integer(response[valid] == "same")
  )
  
  results$total_pairs <- nrow(pairs)
  results$invalid_responses <- sum(!valid)
  results$coverage <- mean(valid)
  
  results
}
