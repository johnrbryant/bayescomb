
library(dembase)
library(dplyr)
library(magrittr)

popn <- readRDS("out/popn.rds")

nhes_obese_num_sd <- readRDS("out/nhes_obese_pr_sd.rds") %>%
    multiply_by(popn)

saveRDS(nhes_obese_num_sd,
        file = "out/nhes_obese_num_sd.rds")
