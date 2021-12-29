
library(dembase)
library(dplyr)
library(readr)

dtc_obese_pr_mean <- read_csv("../data/dtc.csv") %>%
    dtabs(mean ~ age + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(dtc_obese_pr_mean,
        file = "out/dtc_obese_pr_mean.rds")
