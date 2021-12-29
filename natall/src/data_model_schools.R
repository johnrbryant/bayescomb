
library(demest)
library(dplyr)

constraint <- readRDS("../shared/out/constraint_schools.rds")

data_model_schools <- Model(schools ~ LN2(constraint = constraint,
                                          sd = HalfT(df = Inf, scale = 1),
                                          add1 = FALSE),
                            priorSD = HalfT(df = Inf, scale = 1))

saveRDS(data_model_schools,
        file = "out/data_model_schools.rds")
