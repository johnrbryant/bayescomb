
library(demest)
library(dplyr)

sd <- readRDS("out/dtc_obese_num_sd.rds")

mean <- sd
mean[] <- 1

data_model_dtc <- Model(dtc ~ NormalFixed(mean = mean, sd = sd))

saveRDS(data_model_dtc,
        file = "out/data_model_dtc.rds")
