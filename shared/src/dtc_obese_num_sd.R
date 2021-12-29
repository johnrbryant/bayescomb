
library(dembase)
library(dplyr)
library(magrittr)

popn <- readRDS("out/popn.rds")

dtc_obese_num_sd <- readRDS("out/dtc_obese_pr_sd.rds") %>%
    multiply_by(popn)

saveRDS(dtc_obese_num_sd,
        file = "out/dtc_obese_num_sd.rds")
