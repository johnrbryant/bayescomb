
library(demest)
library(dplyr)
library(docopt)
'
Usage:
replicate_schools.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default: base]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version

set.seed(0)

n_rep <- 19

i_sample <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = "y") %>%
    nIteration() %>%
    sample(size = n_rep)

schools_obs <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = c("datasets", "schools"), impute = FALSE) %>%
    as.data.frame(stringsAsFactors = TRUE) %>%
    mutate(count = round(count)) %>%
    mutate(iteration = "Observed")

years_obs <- schools_obs %>%
    pull(year) %>%
    unique()

mu <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = c("model", "prior", "mean")) %>%
    subarray(iteration %in% i_sample) %>%
    subarray(year %in% years_obs)

sigma <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = c("model", "prior", "sd")) %>%
    subarray(iteration %in% i_sample, drop = FALSE) %>%
    makeCompatible(y = mu)

logit_gamma <- rnorm(n = length(mu),
                     mean = mu,
                     sd = sigma)

gamma <- 1 / (1 + exp(-logit_gamma))

exposure <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = "exposure") %>%
    subarray(year %in% years_obs) %>%
    makeCompatible(y = mu)

lambda  <- lambda <- gamma * exposure

y <- rpois(n = length(lambda), lambda = lambda) %>%
    array(dim = dim(mu), dimnames = dimnames(mu)) %>%
    Counts(dimscales = dimscales(mu))

schools_mean <-  sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = c("dataModels", "schools", "likelihood", "mean")) %>%
    makeCompatible(y = y, subset = TRUE)

schools_sd <- sprintf("out/model_%d_%s.est", prior, version) %>%
    fetch(where = c("dataModels", "schools", "likelihood", "sd")) %>%
    makeCompatible(y = y, subset = TRUE)

error <- rnorm(n = length(y), sd = schools_sd)

schools_rep <- exp(log(y) + schools_mean + error) %>%
    Counts(dimscales = c(year = "Points")) %>%
    resetIterations() %>%
    toInteger(force = TRUE) %>%
    as.data.frame(stringsAsFactors = TRUE) %>%
    mutate(iteration = paste("Replicate", iteration))

replicate_schools <- bind_rows(schools_obs, schools_rep) %>%
    filter(!(region == "Bangkok" & area == "Rural"))

file <- sprintf("out/replicate_schools_%d_%s.rds", prior, version)
saveRDS(replicate_schools,
        file = file)

