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
left <- annotations[annotations$orientation == "left", ]

years <- format(
  as.Date(as.character(left$date), "%d_%m_%Y"),
  "%Y"
)

indices <- t(combn(seq_len(nrow(left)), 2))

indices <- indices[
  years[indices[, 1]] != years[indices[, 2]],
  ,
  drop = FALSE
]

eligible_pairs <- data.frame(
  img1 = as.character(left$path[indices[, 1]]),
  img2 = as.character(left$path[indices[, 2]]),
  same = as.integer(
    left$identity[indices[, 1]] ==
      left$identity[indices[, 2]]
  )
)

table(eligible_pairs$same)
write.csv(
  eligible_pairs,
  "outputs/task3/eligible_pairs.csv",
  row.names = FALSE
)
prompt <- paste(
  "These two photographs show the left side of sea turtles in different years.",
  "Compare their visible facial scale patterns.",
  "Do they show the same individual sea turtle?",
  "Reply with exactly one word: same or different."
)

writeLines(prompt, "outputs/task3/prompt.txt")
sample_file <- "outputs/task3/sampled_pairs.csv"

if (file.exists(sample_file)) {
  sampled_pairs <- read.csv(
    sample_file,
    stringsAsFactors = FALSE
  )
} else {
  set.seed(6101)
  
  matching <- which(eligible_pairs$same == 1)
  different <- which(eligible_pairs$same == 0)
  
  selected <- c(
    sample(matching, 1),
    sample(different, 69)
  )
  
  selected <- sample(selected)
  
  sampled_pairs <- eligible_pairs[selected, ]
  
  sampled_pairs <- cbind(
    pair_id = sprintf("P%03d", seq_len(70)),
    sampled_pairs
  )
  
  write.csv(
    sampled_pairs,
    sample_file,
    row.names = FALSE
  )
}

print(table(sampled_pairs$same))
answers_file <- "outputs/task3/llm_answers.csv"

if (!file.exists(answers_file)) {
  answers <- data.frame(
    pair_id = sampled_pairs$pair_id,
    answer = "",
    model = "",
    date = ""
  )
  
  write.csv(
    answers,
    answers_file,
    row.names = FALSE
  )
}
pair_folder <- "outputs/task3/pair_images"

dir.create(
  pair_folder,
  recursive = TRUE,
  showWarnings = FALSE
)

for (i in seq_len(nrow(sampled_pairs))) {
  originals <- c(
    sampled_pairs$img1[i],
    sampled_pairs$img2[i]
  )
  
  new_names <- paste0(
    sampled_pairs$pair_id[i],
    c("_A.", "_B."),
    tools::file_ext(originals)
  )
  
  copied <- file.copy(
    from = file.path("data/images", originals),
    to = file.path(pair_folder, new_names),
    overwrite = FALSE
  )
  
  if (!all(copied | file.exists(file.path(pair_folder, new_names)))) {
    stop("Some photographs could not be copied.")
  }
}

print(length(list.files(pair_folder)))
