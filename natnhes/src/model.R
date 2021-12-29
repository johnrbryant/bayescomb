
library(demest)
library(dplyr)
library(docopt)
'
Usage:
model.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--mult [default: 0.001]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
mult <- opts$mult %>% as.numeric()

min_burnin <- 250000
target_iter <- 1000
n_chain <- 4
n_burnin <- mult * min_burnin
n_sim <- mult * min_burnin
n_thin <- ceiling((n_sim * n_chain) / target_iter)

system_model <- sprintf("out/system_model_%d.rds", prior) %>%
    readRDS()

y <- readRDS("../shared/out/nhes_obese_eff.rds")

exposure <- readRDS("../shared/out/nhes_all_eff.rds")

set.seed(0)

filename <- sprintf("out/model_%d.est", prior)
Sys.time()
estimateModel(model = system_model,
              y = y,
              exposure = exposure,
              filename = filename,
              nBurnin = n_burnin,
              nSim = n_sim,
              nThin = n_thin,
              nChain = n_chain)
Sys.time()
options(width = 120)
fetchSummary(filename, nSample = 100)




