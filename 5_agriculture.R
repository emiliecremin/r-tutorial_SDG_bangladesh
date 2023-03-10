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

# https://r-graph-gallery.com/220-basic-ggplot2-histogram.html#binSize
# basic histogram
ggplot(bgd_boro_rice, aes(x=Estimate)) + 
  geom_histogram()

# https://bookdown.org/aschmi11/RESMHandbook/data-visualization-in-base-r.html#histogram
hist(bgd_boro_rice$Estimate)
hist(bgd_boro_rice$Estimate, col = "Blue", border = "orange")

# https://www.color-hex.com/color/98cbcd
hist(bgd_boro_rice$Estimate, 
     main = "Distribution of Boro rice production",
     xlab = "Estimate in Metric tones",
     ylab = "Count",
     col = "#98CBCD"
    )

ggplot(bgd_boro_rice, aes(x = Estimate, y = Zila)) +
  geom_bar(stat="identity")

ggplot(bgd_boro_rice, aes(x = Estimate, y = Division)) +
  geom_bar(stat="identity")

ggplot(bgd_boro_rice, aes(x = Division, y = Estimate)) +
  geom_bar(stat="identity")

per_division <- bgd_boro_rice %>%
  group_by(Division) %>%
  summarise_at(vars(Estimate), list(Estimate = sum))
barplot(per_division$Estimate, names.arg=per_division$Division)

install.packages("readxl")
library(dplyr)
library(ggplot2)
library(readxl)
library(sf)
library(stringr)

source("helpers.R")
bgd_agriculture <- read_excel("data/SDGs/Zila-SDG-v2.xlsx", sheet = "SDG1")
bgd_boro_local_rice <- bgd_agriculture %>% dplyr::filter(Indicator=="Boro Rice (Local) Production (Metric ton)")
bgd_boro_hyv_rice <- bgd_agriculture %>% dplyr::filter(Indicator=="Boro Rice (HYV) Production (Metric ton)")
bgd_boro_hybrid_rice <- bgd_agriculture %>% dplyr::filter(Indicator=="Boro Rice (Hybrid) Production (Metric ton)")
hist(bgd_boro_local_rice $ Estimate, breaks = 50)

ext_per_division <- bgd_boro_local_rice %>%
  group_by(Division) %>%
  summarise_at(vars(Estimate), list(Estimate = mean))
barplot(ext_per_division$Estimate, names.arg=ext_per_division$Division, col = "red")

per_division <- bgd_boro_hyv_rice %>%
  group_by(Division) %>%
  summarise_at(vars(Estimate), list(Estimate = mean))

combined <- rbind(ext_per_division$Estimate, per_division$Estimate)
barplot(combined, names.arg=per_division$Division, beside=TRUE)

# Define colors to use
pal = c("red", "blue")

# Add title and colors
barplot(combined,  names.arg=per_division$Division, 
        main = "Types of Boro rice cultivation per division",
        col=pal, beside=TRUE)

# Y axis from 0 to 100
barplot(combined,  names.arg=per_division$Division, 
        main = "Types of Boro rice cultivation per division",
        col=pal, beside=TRUE,
        ylim=c(0,100)
)

# Add legend
legend("topright", inset=c(0,0),
       legend=c("Boro Rice (Local) Production (Metric ton)","Boro Rice (HYV) Production (Metric ton)"),
       col=pal, pt.cex=2, pch=15, xpd=TRUE)


