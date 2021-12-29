

levels_sex_age <- paste(rep(c("Female", "Male"), each = 4),
                        rep(c("2-4", "5-9", "10-14", "15-17"), times = 2))

saveRDS(levels_sex_age,
        file = "out/levels_sex_age.rds")
