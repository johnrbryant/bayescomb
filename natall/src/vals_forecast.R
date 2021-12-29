
library(demest)
library(dplyr)
library(tidyr)
library(docopt)
'
Usage:
vals_forecast.R [options]
Options:
--prior (0|1|2) [default: 1]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()

filename_est <- sprintf("out/model_%d.est", prior)
filename_pred <- sprintf("out/model_%d.pred", prior)

vals_raw <- fetchBoth(filenameEst = filename_est,
                      filenamePred = filename_pred,
                      where = c("model", "likelihood", "prob"))

exposure <- readRDS("../shared/out/popn.rds") %>%
    collapseDimension(margin = c("age", "sex", "year"))

one <- vals_raw %>%
    collapseDimension(margin = "year", weights = exposure) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "one")

nat <- vals_raw %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "nat")

levels_age <- nat %>%
    pull(age) %>%
    unique() %>%
    setdiff(NA)
labels_age <- paste("Age", levels_age)

vals_forecast <- bind_rows(nat, one) %>%
    mutate(age = factor(age, levels = levels_age, labels = labels_age)) %>%
    mutate(quantile = factor(quantile,
                             levels = c("2.5%", "25%", "50%", "75%", "97.5%"),
                             labels = c("y2.5", "y25", "y50", "y75", "y97.5"))) %>%
    spread(key = quantile, value = value) %>%
    arrange(variant, age, sex, year)

file <- sprintf("out/vals_forecast_%d.rds", prior)
saveRDS(vals_forecast,
        file = file)
