
library(dplyr)
library(purrr)
library(tidyr)

priors <- c(0:2, 4)

vals_natnhes <- priors %>%
    sprintf("../natnhes/out/vals_forecast_%d.rds", .) %>%
    map(readRDS) %>%
    setNames(paste("natnhes", priors)) %>%
    bind_rows(.id = "model") %>%
    filter(variant == "one") %>%
    select(model, year, y2.5, y25, y50, y75, y97.5)

vals_natall <- priors %>%
    sprintf("../natall/out/vals_forecast_%d.rds", .) %>%
    map(readRDS) %>%
    setNames(paste("natall", priors)) %>%
    bind_rows(.id = "model") %>%
    filter(variant == "one") %>%
    select(model, year, y2.5, y25, y50, y75, y97.5)

vals_subnatbase <- priors %>%
    sprintf("../subnat/out/vals_forecast_%d_base.rds", .) %>%
    map(readRDS) %>%
    setNames(paste("subnatbase", priors)) %>%
    bind_rows(.id = "model") %>%
    filter(variant == "one") %>%
    select(model, year, y2.5, y25, y50, y75, y97.5)

vals_subnatrev <- priors %>%
    sprintf("../subnat/out/vals_forecast_%d_rev.rds", .) %>%
    map(readRDS) %>%
    setNames(paste("subnatrev", priors)) %>%
    bind_rows(.id = "model") %>%
    filter(variant == "one") %>%
    select(model, year, y2.5, y25, y50, y75, y97.5)


vals_compare <- bind_rows(vals_natnhes,
                          vals_natall,
                          vals_subnatbase,
                          vals_subnatrev) %>%
    separate(model, into = c("model", "prior")) %>%
    mutate(model = factor(model,
                          levels = c("natnhes",
                                     "natall",
                                     "subnatbase",
                                     "subnatrev"),
                          labels = c("National, NHES only",
                                     "National, multiple",
                                     "Subnational, initial model",
                                     "Subnational, revised model")),
           prior = factor(prior,
                          levels = c(0, 4, 2, 1),
                          labels = c("Weakly informative",
                                     "WHO-based weak",
                                     "WHO-based moderate",
                                     "WHO-based strong")))


saveRDS(vals_compare,
        file = "out/vals_compare.rds")
    

