

data_model_nhes <- readRDS("../shared/out/data_model_nhes.rds")

data_model_dtc <- readRDS("../shared/out/data_model_dtc.rds")

data_model_schools_noage <- readRDS("out/data_model_schools_noage.rds")

data_models_noage <- list(data_model_nhes,
                          data_model_dtc,
                          data_model_schools_noage)

saveRDS(data_models_noage,
        file = "out/data_models_noage.rds")
