
library(ggplot2)
library(dplyr)

plot_theme <- readRDS("../shared/out/plot_theme.rds")

palette <- readRDS("../shared/out/palette.rds")

data <- readRDS("out/vals_compare.rds")

p <- ggplot(data, aes(x = year)) +
    facet_grid(rows = vars(model), cols = vars(prior)) +
    geom_ribbon(aes(ymin = y2.5, ymax = y97.5),
                fill = palette$quantiles[[1]]) + 
    geom_ribbon(aes(ymin = y25, ymax = y75),
                fill = palette$quantiles[[2]]) +
    geom_line(aes(y = y50), color = "white", size = 0.2) +
    xlab("Year") +
    ylab("") +
    scale_x_continuous(breaks = c(1990, 2000, 2010, 2020, 2030),
                       labels = c("1990", "2000", "2010", "2020", "")) +
    ylim(0, NA) +
    plot_theme

graphics.off()
tiff(file = "out/fig_compare.tif",
     width = 2250,
     height = 2500,
     units = "px",
     res = 400,
     compression = "lzw")
plot(p)
dev.off()

