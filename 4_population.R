library(dplyr)
library(ggplot2)
library(leaflet)
library(sf)
library(stringr)

bgd_pop <- read.csv(file = "data/SDGs/population.csv")
head(bgd_pop)

bgd_shp <- read_sf(dsn = "data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")
head(bgd_shp)

bgd_pop_2011 <- bgd_pop %>% dplyr::filter(Year==2011 & Definition=="Total Population in 2011")
head(bgd_pop_2011)

bgd_pop_2011$ADM2_PCODE <- paste("BD", str_pad(bgd_pop_2011$DivisionCode, 2, pad = "0"), str_pad(bgd_pop_2011$ZilaCode, 2, pad = "0"), sep="")
head(bgd_pop_2011)

m <- bgd_pop_2011 %>% full_join(y = bgd_shp, by = "ADM2_PCODE") %>%
  st_as_sf()
head(m)

# For each Zila
# 1. Calculate Geometry area in km^2
# 2. Calculate pop density

ggplot() +
  geom_sf(data = m, aes(fill = Estimate)) +
  scale_fill_gradient(name="Population", low = "yellow", high = "red", na.value = NA, breaks = scales::breaks_extended(), labels = scales::comma) +
  ggtitle("Bangladesh Population") +
  coord_sf()

# example
# https://rstudio.github.io/leaflet/choropleths.html

labels <- sprintf(
  "<strong>%s</strong><br/>%g Millions",
  m$Zila, round(m$Estimate / 10^6, digits = 2)
) %>% lapply(htmltools::HTML)

# todo: add color ramp yellow to red
leaflet() %>%
  addTiles() %>%
  addPolygons(data = m,
              label = labels, weight=1, col = 'green')
