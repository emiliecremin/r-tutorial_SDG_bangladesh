source("helpers.R")

bgd_agriculture <- read.csv(file = "data/SDGs/agriculture.csv")
head(bgd_agriculture)

bgd_shp <- read_sf(dsn = "data/bgd_adm_bbs_20201113_SHP/bgd_admbnda_adm2_bbs_20201113.shp")

bgd_boro_rice <- bgd_agriculture %>% dplyr::filter(Indicator=="Boro Rice (Local) Production (Metric ton)")
head(bgd_boro_rice)

addPostcode <- function(df) {
  df$ADM2_PCODE <- paste("BD", str_pad(df$DivisionCode, 2, pad = "0"), str_pad(df$ZilaCode, 2, pad = "0"), sep="")
  return(df)
}

bgd_boro_rice <- addPostcode(bgd_boro_rice)
head(bgd_boro_rice)

joinOnPostcode <- function(df, shp) {
  return(
    df %>% 
    full_join(y = shp, by = "ADM2_PCODE") %>%
    st_as_sf()
  )
}
m <- joinOnPostcode(bgd_boro_rice, bgd_shp)
head(m)

mapPlot <- function(shp, columnName, unit, title) {
  ggplot() +
    geom_sf(data = shp, aes(fill = eval(as.name(columnName)))) +
    scale_fill_gradient(name=unit, low = "yellow", high = "red", na.value = NA, breaks = scales::breaks_extended(), labels = scales::comma) +
    ggtitle(title) +
    coord_sf()
}
mapPlot(m, "Estimate", "Metric tons", "Bangladesh Local Boro Rice production")
