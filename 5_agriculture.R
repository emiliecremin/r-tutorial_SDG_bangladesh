source("helpers.R")

bgd_agriculture <- read.csv(file = "data/SDGs/agriculture.csv")
head(bgd_agriculture)

bgd_shp <- read_sf(dsn = "data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")

bgd_boro_rice <- bgd_agriculture %>% dplyr::filter(Indicator=="Boro Rice (Local) Production (Metric ton)")
head(bgd_boro_rice)

bgd_boro_rice <- addPostcode(bgd_boro_rice)
head(bgd_boro_rice)

m <- joinOnPostcode(bgd_boro_rice, bgd_shp)
head(m)
mapPlot(m, "Estimate", "Metric tons", "Bangladesh Local Boro Rice production")
