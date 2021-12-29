
library(dplyr)
library(demest)
library(docopt)
'
Usage:
system_model.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default:base]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version

prior_year <- sprintf("../shared/out/prior_year_%d.rds", prior) %>%
    readRDS()

structural_zeros <- readRDS("out/structural_zeros.rds")

jump <- if (identical(version, "base")) 1.5 else 3

system_model <- Model(y ~ Binomial(mean ~ age * sex  + age * year + sex * year
                                   + region + area,
                                   structuralZeros = structural_zeros),
                      age ~ ExchFixed(),
                      age:sex ~ ExchFixed(),
                      year ~ prior_year,
                      age:year ~ prior_year,
                      sex:year ~ prior_year,
                      priorSD = HalfT(df = Inf, scale = 0.1),
                      jump = jump)

file <- sprintf("out/system_model_%d_%s.rds", prior, version)
saveRDS(system_model,
        file = file)


