# load packages ----
library(tidyverse)
library(leaflet)

library(tidyverse)
library(leaflet)

# read in data ----
lake_data <- read_csv(here::here("shinydashboard", "data", "lake_data_processed.csv"))

# filtered data
filtered_lakes <- lake_data |> 
  filter(Elevation >= 8 & Elevation <= 20) |> 
  filter(AvgDepth >= 2 & AvgDepth <= 3) |> 
  filter(AvgTemp >= 4 & AvgTemp <= 6)

# leaflet map ----
leaflet() %>% 
  addProviderTiles(providers$Esri.WorldImagery) %>% 
  setView(lng = -152.048442,
          lat = 70.249234,
          zoom = 6) %>% 
  addMiniMap(toggleDisplay = TRUE,
             minimized = FALSE) %>% 
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude,
             lat = filtered_lakes$Latitude,
             popup = paste0("Site name: ", filtered_lakes$Site, "<br>",
                            "Eleveation: ", filtered_lakes$Elevation, "meters about SL", 
                            "<br>",
                            "Avg Depth: ", filtered_lakes$AvgDepth, "meters", "<br>",
                            "Avg Lake Bed Temperature: ", filtered_lakes$AvgDepth, "\u00B0C"))
