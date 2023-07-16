library("dataverse")
library("tibble") # to see dataframes in tidyverse-form
require(sf)
here::i_am("inc/download-dataverse.R")
Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
# Sys.setenv("DATAVERSE_KEY" = readLines(here::here("secrets","dataverse-key.txt")))

gpstrack <- get_dataframe_by_name(
  filename = "05.gpx",
  dataset = "10.7910/DVN/Y1AQKS",
  original = TRUE,
  .f = sf::read_sf)

ruta <- gpstrack %>% filter(grepl("05", name)) %>% select(name) 
