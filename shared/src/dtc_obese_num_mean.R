
library(dembase)
library(dplyr)
library(magrittr)

popn <- readRDS("out/popn.rds")

dtc_obese_num_mean <- readRDS("out/dtc_obese_pr_mean.rds") %>%
    multiply_by(popn) %>%
    toInteger(force = TRUE) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(dtc_obese_num_mean,
        file = "out/dtc_obese_num_mean.rds")
