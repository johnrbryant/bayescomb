
library(dplyr)
library(dembase)

nhes <- readRDS("../shared/out/nhes_obese_num_mean.rds")

dtc <- readRDS("../shared/out/dtc_obese_num_mean.rds")

schools <- readRDS("../shared/out/schools_obese_adj.rds") %>%
    collapseDimension(dimension = c("region", "area"))

datasets <- list(nhes = nhes,
                 dtc = dtc,
                 schools = schools)

saveRDS(datasets,
        file = "out/datasets.rds")










