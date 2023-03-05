library(dplyr)
library(ggplot2)
library(sf)

bgd_shp <- st_read("data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")
head(bgd_shp)

aoi <- bgd_shp %>% dplyr::filter(ADM2_EN=="Khulna")
head(aoi)

ggplot() + 
  geom_sf(data=aoi) +
  ggtitle("Khulna Boundary Plot") + 
  coord_sf()
