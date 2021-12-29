
library(demest)
library(ggplot2)
library(dplyr)
library(magrittr)
library(forcats)
library(docopt)
'
Usage:
fig_forecast.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default: base]
--sex (female|male) [default: female]
--area (urban|rural) [default: urban]
--ext (tif|pdf) [default: tif]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version
sex <- opts$sex
area <- opts$area
ext <- opts$ext

plot_theme <- readRDS("../shared/out/plot_theme.rds")

palette <- readRDS("../shared/out/palette.rds")

data_modelled <- sprintf("out/vals_forecast_%d_%s.rds", prior, version) %>%
    readRDS() %>%
    filter(variant == "subage") %>%
    filter(tolower(sex) == !!sex) %>%
    filter(tolower(area) == !!area)

data_direct_schools <- readRDS("../shared/out/vals_direct_schools.rds") %>%
    filter(variant == "subage") %>%
    filter(tolower(sex) == !!sex) %>%
    filter(tolower(area) == !!area)

if (identical(area, "rural")) {
    data_modelled <- data_modelled %>%
        filter(region != "Bangkok") %>%
        mutate(region = fct_drop(region))
    data_direct_schools <- data_direct_schools %>%
        filter(region != "Bangkok") %>%
        mutate(region = fct_drop(region))
}


p <- ggplot(data_modelled, aes(x = year)) +
    facet_grid(rows = vars(age), cols = vars(region)) +
    geom_ribbon(aes(ymin = y2.5, ymax = y97.5),
                fill = palette$quantiles[[1]]) + 
    geom_ribbon(aes(ymin = y25, ymax = y75),
                fill = palette$quantiles[[2]]) +
    geom_line(aes(y = y50), color = "white", size = 0.2) +
    geom_line(aes(x = year, y = value),
              data = data_direct_schools,
              size = 0.3) +
    xlab("Year") +
    ylab("") +
    scale_x_continuous(breaks = c(1990, 2000, 2010, 2020, 2030),
                       labels = c("", "2000", "", "2020", "")) +
    ylim(0, 0.65) +
    plot_theme

graphics.off()
file <- sprintf("out/fig_forecast_%d_%s_%s_%s.%s",
                prior, version, sex, area, ext)
if (identical(ext, "tif")) {
    tiff(file = file,
         width = 2250,
         height = 1400,
         units = "px",
         res = 400,
         compression = "lzw")
} else {
    pdf(file = file,
        width = 2250/400,
        height = 1400/400)
}
plot(p)
dev.off()
