# R Script: Download georeferenced occurrences from GBIF
# for plant species with blue flowers from Wikidata

# Author: Israel Muñoz Velasco
# Date: 12 August 2025
# Description:
# This script downloads occurrence data with geographical coordinates
# for a list of plant species exhibiting blue flowers obtained from Wikidata.
# It uses the 'rgbif' R package to query the GBIF API, handles errors,
# and consolidates results into a single dataset for spatial analyses.

# Load required packages
library(rgbif)
library(dplyr)
library(readr)
library(ggplot2)
library(maps)

# Load species list CSV
df_species <- read_csv("blue_flowers_species.csv")

# Extract unique species names for query
species_names <- unique(df_species$speciesLabel)

# Function to download data per species with error handling
download_gbif_data <- function(species_name, limit = 5000) {
  message("Downloading data for: ", species_name)
  
  res <- tryCatch({
    occ_data(scientificName = species_name, hasCoordinate = TRUE, limit = limit)
  }, error = function(e) {
    warning(paste("Error downloading:", species_name, ":", e$message))
    return(NULL)
  })
  
  if (!is.null(res) && !is.null(res$data) && nrow(res$data) > 0) {
    df <- res$data
    df$species_searched <- species_name
    return(df)
  } else {
    message("No occurrence data with coordinates for: ", species_name)
    return(NULL)
  }
}

# Download data for all species
all_data_list <- lapply(species_names, download_gbif_data)
all_data_combined <- bind_rows(all_data_list)

# Select relevant columns and remove records without coordinates
gbif_coords <- all_data_combined %>%
  select(species_searched, decimalLongitude, decimalLatitude, country,
         stateProvince, locality, occurrenceStatus, basisOfRecord) %>%
  filter(!is.na(decimalLongitude), !is.na(decimalLatitude))

# Save combined data for future use
write_csv(gbif_coords, "blue_flowers_species_gbif_coordinates.csv")

# Basic world map visualization with points
world_map <- map_data("world")

ggplot() +
  geom_polygon(data = world_map, aes(x = long, y = lat, group = group),
               fill = "gray90", color = "black") +
  geom_point(data = gbif_coords, aes(x = decimalLongitude, y = decimalLatitude),
             color = "#3182bd", alpha = 0.5, size = 1) +
  coord_fixed(1.3) +
  theme_minimal() +
  labs(title = "Geographic distribution of species with blue flowers",
       x = "Longitude", y = "Latitude")

