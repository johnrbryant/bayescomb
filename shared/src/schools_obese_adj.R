
library(dembase)
library(dplyr)


schools_obese <- readRDS("out/schools_obese.rds")
schools_all <- readRDS("out/schools_all.rds")
popn <- readRDS("out/popn.rds")

schools_obese_adj <- ((schools_obese / schools_all) * popn) %>%
    toInteger(force = TRUE)

stopifnot(identical(names(schools_obese_adj), c("age", "sex", "area", "region", "year")))
schools_obese_adj[ , , "Rural", "Bangkok", ] <- 0L ## structural zero

saveRDS(schools_obese_adj,
        file = "out/schools_obese_adj.rds")
