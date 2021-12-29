
library(dembase)
library(dplyr)

constraint_schools <- array(NA_integer_,
                            dim = 4,
                            dimnames = list(age = c("2-4", "5-9", "10-14", "15-17"))) %>%
    Values()

saveRDS(constraint_schools,
        file = "out/constraint_schools.rds")


