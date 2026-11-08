# Sea-Turtle-Photo-Identification

MTH6101 Introduction to Machine Learning group project: Ahsan, Anjanpreet, Matas, Ozair, Reece.

Building and comparing classification models for sea turtle photo-identification (same side matching and dimensionality reduction).

## Layout

- `data/`: raw data (do not edit). The images are not in the repo, as they are too large for GitHub; download them from QMplus and unzip them into `data/images/` if you need them.
- `code/setup.R`: only loads the data we were given and creates the output folders; every script starts with `source("code/setup.R")`
- `code/task1/pairs.R`: builds the pairs everyone uses; scripts that need them also run `source("code/task1/pairs.R")`
- `code/taskN/`: one folder per task, with one file per person; messy is fine
  - `task1/pairs.R` · `task1/similarity.R` · `task2/pair_auc.R` · `task2/roc_auc.R` · `task2/thresholds.R` · `task3/llm.R` · `task4/llm_comparison.R` · `task5/pca.R` · `task5/pca_pairs.R`
- `outputs/taskN/`: that task's plots as `.png` and tables as `.csv` (e.g. `roc_curves.png`); for task 3, also the LLM prompt, the sampled pairs and the LLM's answers
- `code/mock/mock_pairs.R`: **mock data for testing code only; never use it in final results**
- `code/results_table.R`: the combined results table across tasks 2, 4 and 5
- `code/analysis.R`: the shared final code, combining the best work from each task
- `notes/individual-contributions.md`: your contributions, updated as you go
- `notes/decision-notes.md`: analytical choices (what, when, why, alternatives)
- `notes/group-meeting-record.md`: date, attendance, what was discussed, decisions and tasks, written straight after each meeting
- `notes/ai-use-log.md`: log of AI use (which tools and what for); the AI Use Statement is written from it
- `reports/`: group report, appendix, week 10 progress report and individual reflections

## First-time setup

1. Install R, RStudio and git.
2. In RStudio: **File → New Project → Version Control → Git** and paste `https://github.com/reeceama/Sea-Turtle-Photo-Identification.git`
3. Always open the project with `Sea-Turtle-Photo-Identification.Rproj` so file paths work.

## Every time you work

1. **Pull first.** Open the project, go to the **Git** tab (top-right panel) and click the blue **Pull** arrow. This gets everyone else's latest changes before you start.
2. **Work in your own file.** Open your file in `code/taskN/` and try things out. Only edit your own files. It can be messy, and nothing in it gets deleted. Save any plots or tables you want to keep to `outputs/taskN/`, including ones we don't end up using. Until the real pairs are ready, test your code with `source("code/mock/mock_pairs.R")`.
3. **Add good work to the final file.** When something works, click **Pull** again, then copy the clean version into the section for your task in `code/analysis.R`. Run it once in the final file to check it works there too.
4. **Update the notes.** Add what you did to your row in `notes/individual-contributions.md`. If you made an analytical choice (e.g. a threshold or the number of principal components), add an entry to `notes/decision-notes.md` saying what you decided, why, and what else you considered. If you used AI, add it to `notes/ai-use-log.md`.
5. **Commit and push.** In the Git tab:
   - tick the files you changed and click **Commit**;
   - write a short message saying what you did (e.g. `task2 ROC curves`) and click **Commit**;
   - click **Pull** once more in case someone pushed while you worked, then click the green **Push** arrow.

If RStudio reports a **merge conflict**, the file will show both versions between `<<<<<<<` and `>>>>>>>` markers. Don't delete anyone's code; ask in the group chat and fix it together.

## Rules

- Never delete code or outputs, even ones we don't end up using; rough work stays in your own file.
- Mock data never goes into `code/analysis.R`, the figures or the report.
- Keep your row in `notes/individual-contributions.md` accurate and up to date.
- Use relative file paths only (load data with `source("code/setup.R")`), so the code runs on everyone's computer.
