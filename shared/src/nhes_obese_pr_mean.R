
library(dembase)
library(dplyr)
library(readr)

nhes_obese_pr_mean <- read_csv("../data/nhes.csv") %>%
    dtabs(pr_mean ~ age + sex + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(nhes_obese_pr_mean,
        file = "out/nhes_obese_pr_mean.rds")
