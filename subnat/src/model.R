
library(demest)
library(dplyr)
library(docopt)
'
Usage:
model.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default: base]
--mult [default: 0.001]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version
mult <- opts$mult %>% as.numeric()

min_burnin <- 1000000
target_iter <- 1000
n_chain <- 4
n_burnin <- mult * min_burnin
n_sim <- mult * min_burnin
n_thin <- ceiling((n_sim * n_chain) / target_iter)

set.seed(0)

initial <- readRDS("../shared/out/initial_obese.rds")

system_model <- sprintf("out/system_model_%d_%s.rds", prior, version) %>%
    readRDS()

data_models <- sprintf("out/data_models_%s.rds", version) %>%
    readRDS()

popn <- readRDS("../shared/out/popn.rds")

datasets <- readRDS("out/datasets.rds")

filename <- sprintf("out/model_%d_%s.est", prior, version)
Sys.time()
estimateCounts(model = system_model,
               y = initial,
               exposure = popn,
               dataModels = data_models,
               datasets = datasets,
               filename = filename,
               nBurnin = n_burnin,
               nSim = n_sim,
               nThin = n_thin,
               nChain = n_chain)
Sys.time()
options(width = 120)
fetchSummary(filename, nSample = 100)




