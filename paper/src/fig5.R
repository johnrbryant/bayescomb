
library(magick)

files <- paste("out", c("fig5a.tif", "fig5b.tif"), sep = "/")
    
tiff("out/fig5.tif",
     units = "px",
     width = 2100,
     height = 2500,
     res = 100,
     compression = 'lzw')
par(mfrow = c(2, 1))
for (i in 1:2) {
    img <- image_read(files[i])
    plot(img)
}
dev.off()
