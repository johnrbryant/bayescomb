
library(dembase)
library(dplyr)
library(tidyr)
library(readr)

nhes_obese_eff <- read_csv("../data/nhes.csv") %>%
    complete(age = unique(age),
             sex = unique(sex),
             year = seq(from = min(year), to = max(year))) %>%
    dtabs(obese_eff ~ age + sex + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(nhes_obese_eff,
        file = "out/nhes_obese_eff.rds")
