##
## This will create templates with basic information for each NM
library(dplyr)
here::i_am("inc/data-download.R")
dir_temp <- here::here("sandbox","NM-temp")

if (!dir.exists(dir_temp))
  dir.create(dir_temp)

load(here::here("sandbox",  "20150515_NM.rda"))
info.NM <- info.NM %>% 
  filter(Nombre != "", 
         !Fecha %in% "0000-00-00",
         !Estado_actual %in% "por delimitar")
front.matter <- "---
title: \"NM%02d - %s\"
subtitle: \"%s\"
editor_options: 
  chunk_output_type: console
execute:
  echo: false 
  message: false
  warning: false
bibliography: 
  - ../bibTeX/datasets.bibtex
---

## Información básica

"

ubicatex <- "

## Ubicación

```{r}
#| label: Mapa
#| message: false
#| warning: false
require(sf)
library(dplyr)
library(tmap)
library(knitr)
library(readr)

gpstrack <- read_sf(here::here(\"sandbox\",\"%1$s.gpx\"))
ruta <- gpstrack %%>%% filter(grepl(\"%1$s\", name)) %%>%% select(name) 
map1 <- tm_shape(ruta) + tm_symbols( col=\"orchid2\") +tm_minimap()
tmap_leaflet(map1, show = FALSE, add.titles = FALSE)
```

Las coordenadas de los puntos de muestreo están disponibles en un repositorio en Dataverse [@NeoMapas_gpx]
"

for (j in 1:nrow(info.NM)) {
  i <- info.NM %>% slice(j) %>% select(where(~!is.na(.)))
  NMcode <- sprintf("%02d",i$NM)
  archivo_gpx <- here::here("sandbox",sprintf("%02d.gpx",i$NM))
  archivo <- here::here("sandbox", "NM-temp",sprintf("NM%02d.qmd",i$NM))
  
  cat(file=archivo,
      sprintf(front.matter, i$NM, i$Nombre, i$ADM1))
  
  print(i$Nombre) 
  cat(file=archivo,paste(sprintf("**%s**: %s\n",names(i),i),collapse="\n"),append=TRUE)
  if (file.exists(archivo_gpx)) {
    cat(file=archivo,
       sprintf(ubicatex, NMcode), append = TRUE)
  }
  
  cat(file=archivo,"\n\n## Actividades\n\n", append = TRUE)
  if (NMcode %in% jmp.NM$NM) {
    for (yr in  {jmp.NM %>% filter(NM %in% NMcode) %>% distinct(yr) %>% pull})
      cat(file=archivo,
          sprintf("- Muestreo de mariposas en %s\n",yr), 
          append = TRUE)
  }
  if (NMcode %in% scr.NM$NM) {
    for (yr in  {scr.NM %>% filter(NM %in% NMcode) %>% distinct(yr) %>% pull})
      cat(file=archivo,
          sprintf("- Muestreo de escarabajos en %s\n",yr), 
          append = TRUE)
  }
}
