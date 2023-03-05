library(leaflet)
library(sf)

bgd_shp <- st_read("data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")
head(bgd_shp)

leaflet() %>%
  addTiles() %>%
  addPolygons(data = bgd_shp,
              label = bgd_shp$ADMIN_NAME, weight=1, col = 'green')
