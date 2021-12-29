
library(dembase)
library(dplyr)
library(readr)

vals_direct_nhes <- read_csv("../data/nhes.csv") %>%
    mutate(low = pr_mean - 1.96 * pr_sd,
           mean = pr_mean,
           high = pr_mean + 1.96 * pr_sd) %>%
    mutate(age = factor(age,
                        levels = unique(age),
                        labels = paste("Age", unique(age)))) %>%
    select(age, sex, year, low, mean, high)

saveRDS(vals_direct_nhes,
        file = "out/vals_direct_nhes.rds")

