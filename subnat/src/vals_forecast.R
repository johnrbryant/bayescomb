
library(demest)
library(dplyr)
library(tidyr)
library(docopt)
'
Usage:
vals_forecast.R [options]
Options:
--prior (0|1|2) [default: 1]
--version (base|rev) [default: base]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version

filename_est <- sprintf("out/model_%d_%s.est", prior, version)
filename_pred <- sprintf("out/model_%d_%s.pred", prior, version)

vals_raw <- fetchBoth(filenameEst = filename_est,
                      filenamePred = filename_pred,
                      where = c("model", "likelihood", "prob"))

exposure <- fetchBoth(filenameEst = filename_est,
                      filenamePred = filename_pred,
                      where = "exposure")

one <- vals_raw %>%
    collapseDimension(margin = "year", weights = exposure, na.rm = TRUE)%>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "one")

nat <- vals_raw %>%
    collapseDimension(dimension = c("region", "area"), weights = exposure, na.rm = TRUE) %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "nat")
    
subage <- vals_raw %>%
    collapseIterations(prob = c(0.025, 0.25, 0.5, 0.75, 0.975), na.rm = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE, responseName = "value") %>%
    mutate(variant = "subage")

levels_age <- nat %>%
    pull(age) %>%
    unique() %>%
    setdiff(NA)
labels_age <- paste("Age", levels_age)

vals_forecast <- bind_rows(subage, one, nat) %>%
    mutate(age = factor(age, levels = levels_age, labels = labels_age)) %>%
    mutate(value = ifelse(!is.na(region) & region == "Bangkok" & area == "Rural", NA, value)) %>%
    mutate(quantile = factor(quantile,
                             levels = c("2.5%", "25%", "50%", "75%", "97.5%"),
                             labels = c("y2.5", "y25", "y50", "y75", "y97.5"))) %>%
    pivot_wider(names_from = quantile, values_from = value) %>%
    arrange(variant, region, area, age, sex, year)

file <- sprintf("out/vals_forecast_%d_%s.rds", prior, version)
saveRDS(vals_forecast,
        file = file)
