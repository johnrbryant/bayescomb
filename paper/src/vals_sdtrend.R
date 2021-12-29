
library(dplyr)
library(demest)

natnhes <- fetch("../natnhes/out/model_0.est",
                 where = c("model", "hyper", "year", "scaleTrend")) %>%
    collapseIterations(prob = c(0.025, 0.975)) %>%
    as.data.frame() %>%
    mutate(model = "natnhes")

natall0 <- fetch("../natall/out/model_0.est",
                 where = c("model", "hyper", "year", "scaleTrend")) %>%
    collapseIterations(prob = c(0.025, 0.975)) %>%
    as.data.frame() %>%
    mutate(model = "natall0")

natall2 <- fetch("../natall/out/model_2.est",
                 where = c("model", "hyper", "year", "scaleTrend")) %>%
    collapseIterations(prob = c(0.025, 0.975)) %>%
    as.data.frame() %>%
    mutate(model = "natall2")


vals_sdtrend <- bind_rows(natnhes,
                          natall0,
                          natall2)

saveRDS(vals_sdtrend,
        file = "out/vals_sdtrend.rds")
    

