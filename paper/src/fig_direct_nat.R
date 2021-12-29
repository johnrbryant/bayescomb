
library(dplyr)
library(ggplot2)

plot_theme <- readRDS("../shared/out/plot_theme.rds")

data_nhes <- readRDS("../shared/out/vals_direct_nhes.rds")

data_dtc <- readRDS("../shared/out/vals_direct_dtc.rds")

data_schools <- readRDS("../shared/out/vals_direct_schools.rds") %>%
    filter(variant == "nat")

p <- ggplot(data_nhes, aes(x = year)) +
    facet_grid(rows = vars(sex), cols = vars(age)) +
    geom_pointrange(aes(y = mean, ymin = low, ymax = high),
                    size = 0.2) +
    geom_pointrange(aes(y = mean, ymin = low, ymax = high),
                    data = data_dtc,
                    size = 0.2,
                    shape = 4) +
    geom_line(aes(x = year, y = value),
              data = data_schools,
              size = 0.5) +
    scale_x_continuous(labels = c(1990, 2000, 2010, "")) +
    xlab("Year") +
    ylab("Proportion") +
    plot_theme

graphics.off()
tiff(file = "out/fig_direct_nat.tif",
     width = 2250,
     height = 1200,
     units = "px",
     res = 400,
     compression = "lzw")
plot(p)
dev.off()
