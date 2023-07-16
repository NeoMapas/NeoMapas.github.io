library("dataverse")
here::i_am("inc/download-dataverse.R")
Sys.setenv("DATAVERSE_SERVER" = "dataverse.harvard.edu")
# Sys.setenv("DATAVERSE_KEY" = readLines(here::here("secrets","dataverse-key.txt")))
