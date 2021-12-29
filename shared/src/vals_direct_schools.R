
library(dembase)
library(dplyr)
library(magrittr)

schools_obese_adj <- readRDS("out/schools_obese_adj.rds")

popn <- readRDS("out/popn.rds")

nat <- schools_obese_adj %>%
    collapseDimension(dimension = c("region", "area"), na.rm = TRUE) %>%
    divide_by(popn) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "nat")

subage <- schools_obese_adj %>%
    divide_by(popn) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "subage")

levels_age <- nat %>%
    pull(age) %>%
    unique() %>%
    setdiff(NA)
labels_age <- paste("Age", levels_age)

vals_direct_schools <- bind_rows(nat, subage) %>%
    mutate(age = factor(age,
                        levels = levels_age,
                        labels = labels_age)) %>%
    mutate(value = ifelse(!is.na(region) & region == "Bangkok" & area == "Rural",
                          NA,
                          value))

saveRDS(vals_direct_schools,
        file = "out/vals_direct_schools.rds")
