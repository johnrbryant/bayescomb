
library(magick)

files <- paste("out", c("fig3a.tif", "fig3b.tif", "fig3c.tif"), sep = "/")
    
tiff("out/fig3.tif",
     units = "px",
     width = 1900,
     height = 2500,
     res = 100,
     compression = 'lzw')
par(mfrow = c(3, 1))
for (i in 1:3) {
    img <- image_read(files[i])
    plot(img)
}
dev.off()
