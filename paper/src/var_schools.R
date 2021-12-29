
library(dplyr)
library(dembase)

prev <- (readRDS("../shared/out/schools_obese.rds") /
         readRDS("../shared/out/schools_all.rds")) %>%
    log() %>%
    as.data.frame() %>%
    filter(!((region == "Bangkok") & (area == "Rural")))

mod <- lm(value ~ (age + sex + year)^2 + region + area,
          data = prev)

var_schools <- summary(mod)$sigma^2

saveRDS(var_schools,
        file = "out/var_schools.rds")
