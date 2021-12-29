
library(dembase)
library(dplyr)

set.seed(0)

schools <- readRDS("out/schools_obese.rds")

growth <- growth(schools, along = "year")

initial_obese <- (runif(n = length(schools), 1, 1.4) * schools) %>%
    extrapolate(along = "year", labels = 1991:2012, growth = growth) %>%
    toInteger(force = TRUE)

saveRDS(initial_obese,
        file = "out/initial_obese.rds")
