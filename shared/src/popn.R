
library(dembase)
library(dplyr)
library(readr)

popn <- read_csv("../data/popn.csv") %>%
    dtabs(count ~ age + sex + area + region + year) %>%
    Counts(dimscales = c(year = "Points",
                         age = "Intervals")) %>%
    toInteger(force = TRUE)

saveRDS(popn,
        file = "out/popn.rds")
