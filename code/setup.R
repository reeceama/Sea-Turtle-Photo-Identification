# Shared setup: run at the top of every script with source("code/setup.R")
# Only loads the data we were given and creates the output folders; task work lives in code/taskN/.
# Open the project via Sea-Turtle-Photo-Identification.Rproj so paths work.

annotations <- read.csv("data/annotations.csv", stringsAsFactors = TRUE)
bbox        <- read.csv("data/bbox.csv", stringsAsFactors = TRUE)
features    <- read.csv("data/ZakynthosTurtles_MegaDescriptor_features.csv", stringsAsFactors = TRUE)

# Make sure every task outputs folder exists
for (task in c("task1", "task2", "task3", "task4", "task5")) {
  dir.create(file.path("outputs", task), recursive = TRUE, showWarnings = FALSE)
}
