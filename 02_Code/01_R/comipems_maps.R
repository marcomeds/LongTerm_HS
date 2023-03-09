#' @Nombre: comipems_maps.R
#' 
#' @Author: Marco Medina
#' 
#' @Descripción: Create maps for the COMIPEMS schools.
#' 
#' @Date: 08/03/2023
#' 
#' @In: latlong.csv
#'      school-list.csv
#' 
#' @Out: 
#' 

# Libraries
pacman::p_load(readr, dplyr, ggplot2, ggthemes, scales, tidyr, stringr,
               leaflet, mapview, webshot, htmlwidgets, ggmap)

# Load data---------------------------------------------------------------------
# Latitude and longitude data from mapas.comipems.org
latlong <- read.csv("01_Data/01_Raw/04_SCRAPE/latlong.csv", na.strings=c("-", ""),
                    colClasses = c("character", "numeric", "numeric")) %>%
  mutate(school = str_pad(school, width = 6, side = "left", pad = "0"))

# COMIPEMS school list
schools <- read.csv("01_Data/01_Raw/04_SCRAPE/school-list.csv") %>%
  mutate(school = str_c(Clave.de.la.opción, 
                        str_pad(X, width = 2, side = "left", pad = "0"),
                        str_pad(X.1, width = 3, side = "left", pad = "0"))) %>%
  rename(institution = Institución,
         nombre_plantel = Nombre.del.Plantel,
         domicilio = Domicilio) %>%
  mutate(institution = factor(institution,
                              levels = c("COLBACH", "SE", "DGB", "UAEM",
                                         "CONALEP", "DGETA", "DGETI",
                                         "IPN", "UNAM")))

# Join data
data <- schools %>% 
  left_join(latlong, by = "school") %>%
  # Keep on observation per school, not option (schools may offer more than one choice)
  distinct(nombre_plantel, domicilio, .keep_all = T)

# MAP --------------------------------------------------------------------------

# Using Leaflet
factpal <- colorFactor(calc_pal()(9), data$institution)

m <- leaflet(data %>% filter(!is.na(lat))) %>%
  addTiles() %>%
  setView(lng = mean(data$long, na.rm = T),
          lat = mean(data$lat, na.rm = T),
          zoom = 11) %>%
#  fitBounds(min(data$long, na.rm = T)*0.999, 
#            min(data$lat, na.rm = T)*1.001,
#            max(data$long, na.rm = T)*1.001,
#            max(data$lat, na.rm = T)*0.999) %>%
  addProviderTiles(providers$CartoDB.VoyagerLabelsUnder) %>%
  addCircles(lat = ~lat, 
             lng = ~long, 
             color = ~factpal(institution),
             radius = 500,
             fillOpacity = 0.8,
             stroke = F,
             fill = T) %>%
  addLegend("topright",
            pal = factpal,
            values = ~institution,
            title = "School System",
            opacity = 1) 

mapshot(m, file = "04_Figures/comipems_type_map_leaflet.pdf")

# Using ggmap
height <- 0.5
width <- 0.5

borders <- c(bottom  = min(data$lat, na.rm = T)  - 0.1 * height, 
             top     = max(data$lat, na.rm = T)  + 0.1 * height,
             left    = min(data$long, na.rm = T) - 0.1 * width,
             right   = max(data$long, na.rm = T) + 0.3 * width)

map <- get_stamenmap(borders, zoom = 10, maptype = "toner-lite", color = "color", force = T)

ggmap(map, darken = c(0.3, "white")) +
  geom_point(data = data, aes(x = long,
                              y = lat, 
                              color = institution,
                              shape = institution),
             size = 2,
             alpha = 0.9) +
  scale_color_calc(name = "School System") +
  scale_shape_manual(values = c(16, 16, 16, 16, 17, 17, 17, 15, 15),
                     name = "School System") +
  #guides(color = guide_legend(ncol = 2, byrow = T)) +
  theme(legend.background = element_blank(),
        legend.box.background = element_rect(colour = "black"),
        legend.key = element_blank(),
        legend.position = c(0.9, 0.5),
        axis.ticks = element_blank(),
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.text.x=element_blank())

ggsave("04_Figures/comipems_type_map_ggmap.pdf",
       width = 6,
       height = 5)
