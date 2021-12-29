
library(ggplot2)
library(dplyr)
library(docopt)
'
Usage:
fig_rep_region.R [options]
Options:
--prior (0|1|2|4) [default: 2]
--version (base|rev) [default: base]
--ext (tif|pdf) [default: tif]
' -> doc
opts <- docopt(doc)
prior <- opts$prior %>% as.integer()
version <- opts$version
ext <- opts$ext

plot_theme <- readRDS("../shared/out/plot_theme.rds")

## Restricting to females only

data <- sprintf("out/vals_rep_region_%d_%s.rds", prior, version) %>%
    readRDS() %>%
    filter(iteration %in% head(unique(iteration), 8)) %>%
    filter(sex == "Female")

p <- ggplot(data, aes(x = region, y = coef_year, shape = area)) +
    facet_grid(vars(age), vars(iteration), scale = "free_y") +
    geom_point(size = 0.7) +
    scale_shape_manual(values = c(Urban = 19, Rural = 21)) +
    xlab("") +
    ylab("") +
    plot_theme +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

graphics.off()
file <- sprintf("out/fig_rep_region_%d_%s.%s",
                prior, version, ext)
if (identical(ext, "tif")) {
    tiff(file = file,
         width = 2250,
         height = 1500,
         units = "px",
         res = 400,
         compression = "lzw")
} else {
    pdf(file = file,
        width = 2250/400,
        height = 1500/400)
}
plot(p)
dev.off()

