
library(RColorBrewer)

palette = list(quantiles = brewer.pal(3, "Blues")[c(2, 3)],
               sex = c(Female = "darkblue", Male = "darkorange"))

saveRDS(palette,
        file = "out/palette.rds")
