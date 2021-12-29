
library(ggplot2)
library(dplyr)
library(docopt)
'
Usage:
fig_forecast.R [options]
Options:
--prior (0|1|2) [default: 1]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()

plot_theme <- readRDS("../shared/out/plot_theme.rds")

palette <- readRDS("../shared/out/palette.rds")

data_modelled <- sprintf("out/vals_forecast_%d.rds", prior) %>%
    readRDS() %>%
    filter(variant == "nat")

data_direct_nhes <- readRDS("../shared/out/vals_direct_nhes.rds")

data_direct_dtc <- readRDS("../shared/out/vals_direct_dtc.rds")

data_direct_schools <- sprintf("../shared/out/vals_direct_schools.rds") %>%
    readRDS() %>%
    filter(variant == "nat")

p <- ggplot(data_modelled, aes(x = year)) +
    facet_grid(rows = vars(sex), cols = vars(age)) +
    geom_ribbon(aes(ymin = y2.5, ymax = y97.5),
                fill = palette$quantiles[[1]]) + 
    geom_ribbon(aes(ymin = y25, ymax = y75),
                fill = palette$quantiles[[2]]) +
    geom_line(aes(y = y50), color = "white", size = 0.2) +
    geom_pointrange(aes(ymin = low, y = mean, ymax = high),
                    data = data_direct_dtc,
                    color = "black",
                    shape = 4,
                    size = 0.1) +
    geom_pointrange(aes(ymin = low, y = mean, ymax = high),
                    data = data_direct_nhes,
                    color = "black",
                    size = 0.1) +
    geom_line(aes(x = year, y = value),
              data = data_direct_schools,
              size = 0.5) +
    scale_x_continuous(breaks = c(1990, 2000, 2010, 2020, 2030),
                       labels = c(1990, 2000, 2010, 2020, "")) +
    xlab("Year") +
    ylab("") +
    ylim(0, 0.7) +
    plot_theme

graphics.off()
file <- sprintf("out/fig_forecast_%d.tif", prior)
tiff(file = file,
     width = 2250,
     height = 1200,
     units = "px",
     res = 400,
     compression = "lzw")
plot(p)
dev.off()
