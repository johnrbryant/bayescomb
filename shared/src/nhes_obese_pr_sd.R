
library(dembase)
library(dplyr)
library(readr)

nhes_obese_pr_sd <- read_csv("../data/nhes.csv") %>%
    dtabs(pr_sd ~ age + sex + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(nhes_obese_pr_sd,
        file = "out/nhes_obese_pr_sd.rds")
