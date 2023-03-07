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
