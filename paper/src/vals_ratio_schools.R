
library(dembase)
library(dplyr)
library(magrittr)


schools_all <- readRDS("../shared/out/schools_all.rds")

popn <- readRDS("../shared/out/popn.rds")

vals_ratio_schools <- (schools_all / popn) %>%
    collapseDimension(dimension = c("sex", "year"), weights = popn) %>%
    as.data.frame(stringsAsFactors = TRUE) %>%
    mutate(age = factor(age, levels = levels(age), labels = paste("Age", levels(age)))) %>%
    mutate(region = factor(region, levels = rev(levels(region))))

saveRDS(vals_ratio_schools,
        file = "out/vals_ratio_schools.rds")
