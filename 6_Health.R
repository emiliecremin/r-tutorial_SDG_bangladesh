library(dplyr)
library(ggplot2)
library(sf)
library(stringr)

source("helpers.R")

bgd_health <- read.csv(file = "data/SDGs/Health.csv")
bgd_shp <- read_sf(dsn = "./data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")
bgd_fertility_rate <- bgd_health %>% dplyr::filter(Indicator=="General fertility rate (Number per 1000 women)")
bgd_fertility_rate <- addPostcode(bgd_fertility_rate)
m <- joinOnPostcode(bgd_fertility_rate, bgd_shp)
mapPlot(m, "Estimate", "Nb per 1000 women", "Fertility rate")
