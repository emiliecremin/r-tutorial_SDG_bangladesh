library(sf)
library(ggplot2)

bgd_shp <- st_read("data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")
head(bgd_shp)

ggplot() + 
  geom_sf(data=bgd_shp) +
  ggtitle("Bangladesh Boundary Plot") + 
  coord_sf()
