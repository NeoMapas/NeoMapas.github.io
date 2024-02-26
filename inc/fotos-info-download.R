
# Fotos from iNaturalist -----

here::i_am("inc/fotos-info-download.R")
if (!require(rinat)) {
  install.packages("rinat")
  library(rinat)
}
# Download observations and save to RDS file
user_obs <- get_inat_obs_user("NeoMapas",maxresults = 5000)
if (!dir.exists(here::here("data")))
    dir.create(here::here("data"))
file_name <- here::here("data","iNaturalist-obs-NeoMapas.rds")
saveRDS(file=file_name, user_obs)

# Fotos from Flickr

if (!require(FlickrAPI)) {
    install.packages("FlickrAPI")
    library(FlickrAPI)
    setFlickrAPIKey(api_key = "YOUR_API_KEY_HERE", install = TRUE)
}

library(dplyr)
readRenviron("~/.Renviron") # read the API key
uid <- "199798864@N08"
i <- 1
photos <- getPhotos(user_id = uid, 
                    img_size="m", 
                    extras = c("description","owner_name", "url_m", "tags"), 
                    per_page=1000, page=i)

dim(photos)

file_name <- here::here("data","flickr-photos.rds")
saveRDS(file=file_name, photos)
