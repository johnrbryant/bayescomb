
library(dplyr)
library(ggplot2)
library(docopt)
'
Usage:
fig_direct_subage.R [options]
Options:
--sex (female|male) [default: female]
--ext (tif|pdf) [default: tif]
' -> doc
opts <- docopt(doc)
sex <- opts$sex
ext <- opts$ext

plot_theme <- readRDS("../shared/out/plot_theme.rds")

levels_area <- c("Urban", "Rural")

data <- readRDS("../shared/out/vals_direct_schools.rds") %>%
    filter(variant == "subage") %>%
    filter(tolower(sex) == !!sex) %>%
    mutate(area = factor(area, levels = c("Urban", "Rural")))

p <- ggplot(data, aes(x = year, y = value, linetype = area)) +
    facet_grid(rows = vars(age), cols = vars(region)) +
    geom_line() +
    xlab("Year") +
    ylab("") +
    ylim(0, NA) +
    scale_x_continuous(breaks = c(2014, 2016, 2018), labels = c(2014, "", 2018)) +
    plot_theme +
    theme(text = element_text(size = 7),
          legend.position = "right",
          panel.spacing = unit(0.2, "lines"))


file <- sprintf("out/fig_direct_subage_%s.%s", sex, ext)
graphics.off()
if (identical(ext, "tif")) {
    tiff(file = file,
         width = 2250,
         height = 1200,
         units = "px",
         res = 400,
         compression = "lzw")
} else {
    pdf(file = file,
        width = 2250/400,
        height = 1200/400)
}
plot(p)
dev.off()
