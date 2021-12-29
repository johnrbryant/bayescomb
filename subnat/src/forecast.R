
library(demest)
library(dplyr)
library(magrittr)
library(docopt)
'
Usage:
forecast.R [options]
Options:
--prior (0|1|2) [default: 1]
--version (base|rev) [default: base]
--year_max [default: 2030]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version
year_max_pred <- opts$year_max %>% as.integer()

filename_est <- sprintf("out/model_%d_%s.est", prior, version)
filename_pred <- sprintf("out/model_%d_%s.pred", prior, version)

year_max_est <- fetch(filename_est, where = "exposure") %>%
    dimnames() %>%
    extract2("year") %>%
    as.integer() %>%
    max()

exposure <- readRDS("../shared/out/popn.rds") %>%
    subarray(year > year_max_est) %>%
    subarray(year <= year_max_pred)

n <- year_max_pred - year_max_est

predictCounts(filenameEst = filename_est,
              filenamePred = filename_pred,
              n = n,
              exposure = exposure)

