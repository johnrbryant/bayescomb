
library(dembase)
library(dplyr)
library(magrittr)


schools_all <- readRDS("../shared/out/schools_all.rds") %>%
    collapseDimension(margin = "year")

popn <- readRDS("../shared/out/popn.rds") %>%
    subarray(year %in% dimnames(schools_all)$year) %>%
    sum()

schools_all <- schools_all %>%
    sum()

vals_ratio_schools_overall <- (schools_all / popn)

saveRDS(vals_ratio_schools_overall,
        file = "out/vals_ratio_schools_overall.rds")
