
library(demest)
library(dplyr)

sd <- readRDS("out/nhes_obese_num_sd.rds")

sd[is.na(sd)] <- 0 ## 'demest' does not allow NA; in practice, value is ignored

mean <- sd
mean[] <- 1

data_model_nhes <- Model(nhes ~ NormalFixed(mean = mean, sd = sd))

saveRDS(data_model_nhes,
        file = "out/data_model_nhes.rds")
