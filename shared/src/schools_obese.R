
library(dembase)
library(dplyr)
library(readr)

schools_obese <- read_csv("../data/schools.csv") %>%
    dtabs(obese ~ age + sex + area + region + year) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(schools_obese,
        file = "out/schools_obese.rds")
