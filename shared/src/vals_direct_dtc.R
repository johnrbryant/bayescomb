
library(dembase)
library(dplyr)
library(readr)

levels_age <- c("2-4", "5-9", "10-14", "15-17")
labels_age <- paste("Age", levels_age)

both_sexes <- read_csv("../data/dtc.csv")

vals_direct_dtc <- bind_cols(sex = c("Female", "Male"),
                             bind_rows(both_sexes, both_sexes)) %>%
    mutate(low = mean - 1.96 * se,
           high = mean + 1.96 * se) %>%
    mutate(age = factor(age,
                        levels = levels_age,
                        labels = labels_age)) %>%
    select(age, sex, year, low, mean, high)

saveRDS(vals_direct_dtc,
        file = "out/vals_direct_dtc.rds")
