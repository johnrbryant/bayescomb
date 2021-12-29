
library(ggplot2)

plot_theme <- theme(text = element_text(size = 9),
                    legend.title = element_blank(),
                    legend.position = "top",
                    strip.text.x = element_text(margin = margin(1, 1, 1, 1, "pt")),
                    strip.text.y = element_text(margin = margin(1, 1, 1, 1, "pt")))
saveRDS(plot_theme,
        file = "out/plot_theme.rds")
