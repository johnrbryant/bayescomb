
library(demest)
library(dplyr)
library(magrittr)
library(docopt)
'
Usage:
forecast.R [options]
Options:
--year_max [default: 2030]
' -> doc
opts <- docopt(doc)
year_max_pred <- opts$year_max %>% as.integer()

filename_est <- "out/model_noage.est"
filename_pred <- "out/model_noage.pred"

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

