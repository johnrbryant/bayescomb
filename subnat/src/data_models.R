
library(demest)
library(dplyr)
library(docopt)
'
Usage:
data_model_schools.R [options]
Options:
--version (base|rev) [default: base]
' -> doc
opts <- docopt(doc)
version <- opts$version


data_model_nhes <- readRDS("../shared/out/data_model_nhes.rds")

data_model_dtc <- readRDS("../shared/out/data_model_dtc.rds")

data_model_schools <- sprintf("out/data_model_schools_%s.rds", version) %>%
    readRDS()

data_models <- list(data_model_nhes,
                    data_model_dtc,
                    data_model_schools)

file <- sprintf("out/data_models_%s.rds", version)
saveRDS(data_models,
        file = file)
