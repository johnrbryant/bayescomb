
library(dembase)
library(dplyr)
library(magrittr)

popn <- readRDS("out/popn.rds")

nhes_obese_num_mean <- readRDS("out/nhes_obese_pr_mean.rds") %>%
    multiply_by(popn) %>%
    toInteger(force = TRUE) %>%
    Counts(dimscales = c(year = "Points"))

saveRDS(nhes_obese_num_mean,
        file = "out/nhes_obese_num_mean.rds")
