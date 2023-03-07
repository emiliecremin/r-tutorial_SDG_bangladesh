install.packages("readxl")
library(dplyr)
library(ggplot2)
library(readxl)
library(sf)
library(stringr)

source("helpers.R")
bgd_poverty <- read_excel("data/SDGs/Zila-SDG-v2.xlsx", sheet = "SDG1")
bgd_ext_poverty_rate <- bgd_poverty %>% dplyr::filter(Indicator=="Extreme poverty rate (Percent)")
bgd_poverty_rate <- bgd_poverty %>% dplyr::filter(Indicator=="Poverty rate (Percent)")
hist(bgd_ext_poverty_rate$Estimate)

ext_per_division <- bgd_ext_poverty_rate %>%
  group_by(Division) %>%
  summarise_at(vars(Estimate), list(Estimate = mean))
barplot(ext_per_division$Estimate, names.arg=ext_per_division$Division, col = "red")

per_division <- bgd_poverty_rate %>%
  group_by(Division) %>%
  summarise_at(vars(Estimate), list(Estimate = mean))

combined <- rbind(ext_per_division$Estimate, per_division$Estimate)
barplot(combined, names.arg=per_division$Division, beside=TRUE)

# Define colors to use
pal = c("red", "blue")

# Add title and colors
barplot(combined,  names.arg=per_division$Division, 
        main = "Poverty and Extreme poverty rate per division",
        col=pal, beside=TRUE)

# Y axis from 0 to 100
barplot(combined,  names.arg=per_division$Division, 
        main = "Poverty and Extreme poverty rate per division",
        col=pal, beside=TRUE,
        ylim=c(0,100)
)

# Add legend
legend("topright", inset=c(0,0),
       legend=c("Extreme Poverty rate","Poverty rate"),
       col=pal, pt.cex=2, pch=15, xpd=TRUE)
