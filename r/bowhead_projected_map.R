library(rgdal)                                                                                                      
library(raster)
library(ggplot2)


proj <- "+proj=stere +lat_0=90 +lat_ts=70 +lon_0=-45 +k=1 +x_0=0 +y_0=0 +a=6378273 +b=6356889.449 +units=m +no_defs"
lat_start = 50

data("wrld_simpl", package = "maptools")                                                                            
wm_ggplot <- crop(wrld_simpl, extent(-180, 180, lat_start, 90))                                                                   
###locality coordinates for the map
# setwd("/Users/zld305/Documents/Narwhal/2022_10_20_PaperPlots/2022_10_20_Reworking/Figure1_overview/")
bowhead_points = read.csv("bowhead_sample_info.csv", header=TRUE)
# bowhead_points$Latitude[bowhead_points$Stock == "Sea of Okhotsk"] = 52.87
# bowhead_points$Longitude[bowhead_points$Stock == "Sea of Okhotsk"] = 149.36



# Defines the x axes required
x_lines <- seq(-120,180, by = 60)

ggplot() +
  geom_polygon(data = wm_ggplot, aes(x = long, y = lat, group = group), fill = "#b3b3b3", colour = NA, alpha = 0.8) +
  
  # Convert to polar coordinates
  coord_map("ortho", orientation = c(90, 0, 0)) +
  scale_y_continuous(breaks = seq(lat_start, 90, by = 5), labels = NULL) +
  
  # Removes Axes and labels
  scale_x_continuous(breaks = NULL) +
  xlab("") + 
  ylab("") +
  
  # Adds labels
  geom_text(aes(x = 180, y = seq(60, 85, by = 10), hjust = -0.2, label = paste0(seq(60, 85, by = 10), "°N"))) +
  # geom_text(aes(x = x_lines, y = 53, label = c("120°W", "60°W", "0°", "60°E", "120°E", "180°W")), size = 3, colour = "black") +
  geom_text(aes(x = x_lines, y = 53, label = c("120°W", "60°W", "0°", "60°E", "120°E", "180°W")), colour = "black") +
  
  # Adds axes
  geom_hline(aes(yintercept = lat_start), size = 0.5, colour = "#36454F")  +
  geom_segment(aes(y = lat_start, yend = 90, x = x_lines, xend = x_lines), linetype = "F1") +
  
  # Change theme to remove axes and ticks
  theme(panel.background = element_blank(),
        panel.grid.major = element_line(size = 0.15, linetype = 'F1',
                                        colour = "#36454F"),
        axis.ticks=element_blank()) +

  # Adding points to the map
geom_point(data=bowhead_points, aes(x=Longitude, y=Latitude ,color= Stock),inherit.aes=FALSE, size= 5) +
# geom_point(data=bowhead_points, aes(x=Longitude, y=Latitude ,color= Stock),inherit.aes=FALSE) +
  scale_color_manual(values = c("#000000ff","#cd5870ff",   "#4caf50ff","#3a9bdcff", "#2b879eff")) 
  

  