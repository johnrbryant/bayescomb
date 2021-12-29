

data_model_nhes <- readRDS("../shared/out/data_model_nhes.rds")

data_model_dtc <- readRDS("../shared/out/data_model_dtc.rds")

data_model_schools <- readRDS("out/data_model_schools.rds")

data_models <- list(data_model_nhes,
                    data_model_dtc,
                    data_model_schools)

saveRDS(data_models,
        file = "out/data_models.rds")
