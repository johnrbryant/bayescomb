
library(dembase)
library(dplyr)
library(readr)

dtc_obese_pr_sd <- read_csv("../data/dtc.csv") %>%
    dtabs(se ~ age + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(dtc_obese_pr_sd,
        file = "out/dtc_obese_pr_sd.rds")
