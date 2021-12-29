
library(dplyr)
library(demest)

natall_data <- fetch("../natall/out/model_2.est",
                     where = c("dataModels", "schools", "likelihood", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 3",
           parameter = "Data model")

natall_sys <- fetch("../natall/out/model_2.est",
                      where = c("model", "prior", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 3",
           parameter = "System model")

base_data <- fetch("../subnat/out/model_2_base.est",
                   where = c("dataModels", "schools", "likelihood", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 4",
           parameter = "Data model")

base_sys <- fetch("../subnat/out/model_2_base.est",
                  where = c("model", "prior", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 4",
           parameter = "System model")

rev_data <- fetch("../subnat/out/model_2_rev.est",
                  where = c("dataModels", "schools", "likelihood", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 5",
           parameter = "Data model")

rev_sys <- fetch("../subnat/out/model_2_rev.est",
                  where = c("model", "prior", "sd")) %>%
    collapseIterations(FUN = median) %>%
    as.data.frame() %>%
    mutate(model = "Model 5",
           parameter = "System model")


vals_sd <- bind_rows(natall_data,
                     natall_sys,
                     base_data,
                     base_sys,
                     rev_data,
                     rev_sys) %>%
    mutate(model = factor(model, levels = unique(model))) %>%
    select(model, parameter, value = ".")

saveRDS(vals_sd,
        file = "out/vals_sd.rds")
    

