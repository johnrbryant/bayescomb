
library(dplyr)
library(dembase)
library(magrittr)

structural_zeros <- readRDS("../shared/out/schools_all.rds") %>%
    collapseDimension(margin = c("region", "area")) %>%
    Values() %>%
    inset(1)
structural_zeros["Bangkok", "Rural"] <- 0L

saveRDS(structural_zeros,
        file = "out/structural_zeros.rds")
