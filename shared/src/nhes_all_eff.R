
library(dembase)
library(dplyr)
library(tidyr)
library(readr)

nhes_all_eff <- read_csv("../data/nhes.csv") %>%
    complete(age = unique(age),
             sex = unique(sex),
             year = seq(from = min(year), to = max(year))) %>%
    dtabs(all_eff ~ age + sex + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(nhes_all_eff,
        file = "out/nhes_all_eff.rds")
