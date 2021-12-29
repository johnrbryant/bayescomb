
library(dembase)
library(dplyr)
library(readr)

schools_all <- read_csv("../data/schools.csv") %>%
    dtabs(all ~ age + sex + area + region + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(schools_all,
        file = "out/schools_all.rds")
