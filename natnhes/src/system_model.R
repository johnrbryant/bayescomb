
library(dplyr)
library(demest)
library(docopt)
'
Usage:
system_model.R [options]
Options:
--prior (0|1|2|4) [default: 2]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()

file <- sprintf("../shared/out/prior_year_%d.rds", prior)
prior_year <- readRDS(file)

system_model <- Model(y ~ Binomial(mean ~ age * sex  + age * year + sex * year),
                      age ~ ExchFixed(),
                      year ~ prior_year,
                      age:year ~ prior_year,
                      sex:year ~ prior_year,
                      priorSD = HalfT(df = Inf, scale = 1),
                      jump = 0.17)


file <- sprintf("out/system_model_%d.rds", prior)
saveRDS(system_model,
        file = file)


