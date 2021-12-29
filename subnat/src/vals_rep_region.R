
library(dplyr)
library(tidyr)
library(purrr)
library(forcats)
library(docopt)
'
Usage:
vals_rep_region.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default: base]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version

vals_rep_region <- sprintf("out/replicate_schools_%d_%s.rds", prior, version) %>%
    readRDS() %>%
    nest(data = c(year, count)) %>%
    mutate(mod = map(data, function(x) lm(count ~ year, data = x))) %>%
    mutate(coef_year = map_dbl(mod, function(x) coef(x)[["year"]])) %>%
    select(-data, -mod) %>%
    mutate(age = factor(paste("Age", age), levels = c("Age 2-4", "Age 5-9", "Age 10-14", "Age 15-17"))) %>%
    mutate(area = factor(area, levels = c("Urban", "Rural")))

file <- sprintf("out/vals_rep_region_%d_%s.rds", prior, version)
saveRDS(vals_rep_region,
        file = file)
