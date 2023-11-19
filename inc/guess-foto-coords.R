library(dplyr)
library(sf)
library(tmap)

here::i_am("inc/guess-foto-coords.R")

load(here::here("sandbox","NMppln.rda"))

VBG <- read_sf(here::here("sandbox","VBG.gpkg"))

getCols <- function(fechas) {
  vsts <- tvn.NM %>% filter(fecha %in% fechas) %>% distinct(vst) %>% pull
  jmp.NM %>% filter(vst %in% vsts) %>% distinct(col) %>% pull
}

getXYS <- function(fechas, colectores) {
  vsts <- jmp.NM %>% filter(col %in% colectores) %>% distinct(vst) %>% pull
  slc <- tvn.NM %>% filter(vst %in% vsts,fecha %in% fechas) 
  xys <- slc %>% distinct(NM,vst,lat,lon) %>% st_as_sf(coords=c("lon","lat"), crs="EPSG:4326")
  return(xys)
}

calcUncert <- function(x) {
  x %>% st_transform(crs="EPSG:32619")
  dst <- xys %>% st_transform(crs="EPSG:32619") %>% st_distance() 
  mean(dst[lower.tri(dst)]) 
}


calcCenter <- function(x) {
  x %>% st_union() %>% st_centroid %>% st_coordinates()
}

getCols(c("2006-09-03")) 
xys <- getXYS(c("2006-09-03"),"J van Zoeren") 
xys <- getXYS(c("2006-09-01"),"T Good") 

calcUncert(xys)
calcCenter(xys)


getCols(c("2006-05-16")) 
xys <- getXYS(c("2006-05-16"),"JR. Ferrer Paris") 

getCols(c("2005-05-18")) 
xys <- getXYS(c("2005-05-18"),"JR Ferrer-Paris :: F Rey") 
