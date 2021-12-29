
library(readr)
library(dplyr)
library(demest)
library(docopt)
'
Usage:
prior_year.R [options]
Options:
--mult_var (0|1|2|4) [default: 2]
' -> doc
opts <- docopt(doc)
mult_var <- opts$mult_var %>% as.integer()

if (mult_var == 0L) {
    level <- Level(scale = HalfT(df = Inf))
    trend <- Trend(scale = HalfT(df = Inf))
    error <- Error(scale = HalfT(df = Inf))
    damp  <- Damp()
} else {
    param_hyper_year <- read_csv("../data/param_hyper_year.csv")
    val <- structure(param_hyper_year$value,
                     names = param_hyper_year$parameter)
    level <- Level(scale = HalfT(df = Inf, scale = mult_var * val[["level"]]))
    trend <- Trend(scale = HalfT(df = Inf, scale = mult_var * val[["trend"]]))
    error <- Error(scale = HalfT(df = Inf, scale = mult_var * val[["error"]]))
    ## Scale beta parameters in line with 'mult_var'
    s1 <- val[["shape1"]]
    s2 <- val[["shape2"]]
    m <- s1 / (s1 + s2)
    v <- (s1 * s2) / ((s1 + s2)^2 * (s1 + s2 + 1))
    v <- mult_var * v
    stopifnot(v < m * (1 - m))
    shape1 <- m * (m * (1 - m) / v - 1)
    shape2 <- (1 - m) * shape1
    damp <- Damp(shape1 = shape2, shape2 = shape2)
}

prior_year <- DLM(level = level,
                  trend = trend,
                  damp = damp,
                  error = error)

file <- sprintf("out/prior_year_%s.rds",
                mult_var)

saveRDS(prior_year,
        file = file)
