
library(demest)
library(dplyr)

constraint <- array(NA_integer_,
                    dim = 1,
                    dimnames = list(age = "2-17")) %>%
    Values()

data_model_schools_noage <- Model(schools ~ LN2(constraint = constraint,
                                                sd = HalfT(df = Inf, scale = 1),
                                                add1 = FALSE),
                                  priorSD = HalfT(df = Inf, scale = 1))

saveRDS(data_model_schools_noage,
        file = "out/data_model_schools_noage.rds")
