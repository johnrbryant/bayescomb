
library(demest)
library(dplyr)
library(docopt)
'
Usage:
model_noage.R [options]
Options:
--mult [default: 0.001]
' -> doc
opts <- docopt(doc)
mult <- opts$mult %>% as.numeric()

min_burnin <- 1000000
target_iter <- 1000
n_chain <- 4
n_burnin <- mult * min_burnin
n_sim <- mult * min_burnin
n_thin <- ceiling((n_sim * n_chain) / target_iter)

set.seed(0)

initial <- readRDS("../shared/out/initial_obese.rds") %>%
    collapseDimension(dimension = c("region", "area"))

system_model <- readRDS("out/system_model_2.rds")

data_models_noage <- readRDS("out/data_models_noage.rds")

popn <- readRDS("../shared/out/popn.rds") %>%
    collapseDimension(dimension = c("region", "area"))

datasets <- readRDS("out/datasets.rds")

filename <- "out/model_noage.est"
Sys.time()
estimateCounts(model = system_model,
               y = initial,
               exposure = popn,
               dataModels = data_models_noage,
               datasets = datasets,
               filename = filename,
               nBurnin = n_burnin,
               nSim = n_sim,
               nThin = n_thin,
               nChain = n_chain)
Sys.time()
options(width = 120)
fetchSummary(filename, nSample = 100)




