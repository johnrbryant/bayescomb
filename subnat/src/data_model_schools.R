
library(demest)
library(dplyr)
library(docopt)
'
Usage:
data_model_schools.R [options]
Options:
--version (base|rev) [default: base]
' -> doc
opts <- docopt(doc)
version <- opts$version

structural_zeros <- readRDS("out/structural_zeros.rds")

constraint <- readRDS("../shared/out/constraint_schools.rds")

if (version == "base") {
    sd  <- HalfT(df = Inf, scale = 1)
} else {
    sd <- InvChiSq(df = 30, scaleSq = 0.015)
}

data_model_schools <- Model(schools ~ LN2(constraint = constraint,
                                          structuralZeros = structural_zeros,
                                          sd = sd,
                                          add1 = FALSE),
                            priorSD = HalfT(df = Inf, scale = 1))

file <- sprintf("out/data_model_schools_%s.rds", version)
saveRDS(data_model_schools,
        file = file)
