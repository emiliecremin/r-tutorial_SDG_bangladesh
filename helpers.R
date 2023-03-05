library(dplyr)
library(ggplot2)
library(sf)
library(stringr)

addPostcode <- function(df) {
  df$ADM2_PCODE <- paste("BD", str_pad(df$DivisionCode, 2, pad = "0"), str_pad(df$ZilaCode, 2, pad = "0"), sep="")
  return(df)
}

joinOnPostcode <- function(df, shp) {
  return(
    df %>% 
      dplyr::full_join(y = shp, by = "ADM2_PCODE") %>%
      st_as_sf()
  )
}

mapPlot <- function(shp, columnName, unit, title) {
  ggplot() +
    geom_sf(data = shp, aes(fill = eval(as.name(columnName)))) +
    scale_fill_gradient(name=unit, low = "yellow", high = "red", na.value = NA, breaks = scales::breaks_extended(), labels = scales::comma) +
    ggtitle(title) +
    coord_sf()
}
