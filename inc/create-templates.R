##
## This will create templates with basic information for each NM
library(dplyr)
library(readr)
here::i_am("inc/data-download.R")
dir_temp <- here::here("sandbox","NM-temp")

if (!dir.exists(dir_temp))
  dir.create(dir_temp)

load(here::here("sandbox",  "20150515_NM.rda"))
archivo <- "Amazona-dataset.tab"
Amazonas <- read_delim(here::here("sandbox", archivo), skip=27)

scr.NM <- scr.NM %>% mutate(val=paste(genero,especie))
jmp.NM <- jmp.NM %>% mutate(val=paste(genero,especie))
endemicas <- c("Steromapedaliodes sanchezi", "Ardaris eximia", "Steromapedaliodes schuberti")

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
  - ../bibTeX/peer-review.bibtex
  - ../bibTeX/preprints.bibtex
  - ../bibTeX/other.bibtex
---

## Información básica

"
referencias <- "
# Documentos

Publicaciones, conjuntos de datos y otros documentos que se refieren a esta unidad regional de análisis.

::: {#refs}
:::

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

Las coordenadas de los puntos de muestreo están disponibles en un repositorio en Dataverse [@NeoMapas_gpx].
"

for (j in 1:nrow(info.NM)) {
  i <- info.NM %>% slice(j) %>% select(where(~!is.na(.)))
  NMcode <- sprintf("%02d",i$NM)
  archivo_gpx <- here::here("sandbox",sprintf("%02d.gpx",i$NM))
  archivo <- here::here("sandbox", "NM-temp",sprintf("NM%02d.qmd",i$NM))
  archivo_final <- here::here("NM",sprintf("NM%02d.qmd",i$NM))
  listo <- 0

  cat(file=archivo,
      sprintf(front.matter, i$NM, i$Nombre, i$ADM1))
  
  
  cat(file=archivo,paste(sprintf("**%s**: %s\n",names(i),i),collapse="\n"),append=TRUE)
  if (file.exists(archivo_gpx)) {
    cat(file=archivo,
       sprintf(ubicatex, NMcode), append = TRUE)
    listo <- listo+1
  }
  
  cat(file=archivo,"\n\n## Actividades\n\n", append = TRUE)
  if (NMcode %in% jmp.NM$NM) {
    yrs <- {jmp.NM %>% filter(NM %in% NMcode) %>% distinct(yr) %>% pull}
    if (length(yrs)>0) {
      cat(file=archivo,
          sprintf("- Muestreo de mariposas en %s [@Ferrer_Paris_2012]\n",
                  paste(yrs, collapse=", ")),
          append = TRUE)
      listo <- listo+1
    }
  }
  if (NMcode %in% scr.NM$NM) {
    yrs <- {scr.NM %>% filter(NM %in% NMcode) %>% distinct(yr) %>% pull}
    for (yr in yrs) {
      cat(file=archivo,
          if_else(yr %in% 2005:2006,
                  sprintf("- Estudio piloto de muestreo de escarabajos en %s [@Ferrer_Paris_2013]\n",yr),
                  sprintf("- Muestreo nacional de escarabajos en %s [@Ferrer_Paris_2012]\n",yr)
                  ),
            append = TRUE)    
      listo <- listo+1
    }
    
    }
  if (sprintf("NM%02d",i$NM) %in% Amazonas$Code) {
    cat(file=archivo,
        sprintf("- Muestreo de aves en 2010 [@Rodr_guez_2012]\n"), 
        append = TRUE)
    pericos <- Amazonas %>% 
      filter(Code==sprintf("NM%02d",i$NM)) %>% 
      select(starts_with("A.")) %>% 
      select(where(~sum(.) > 0)) %>% 
      rename_with(~ gsub(" [#]", "", .x, fixed = TRUE)) %>% 
      colnames()
  } else {pericos <- c()}
  
  cat(file=archivo,
      "\n\n## Hallazgos importantes\n\n",
      append = TRUE)
  if (length(pericos)>0) {
    cat(file=archivo,
        sprintf("Se observaron las siguientes especies del género Amazona: %s [@Amazona_pangaea_dataset].\n\n",
                paste(sprintf("*%s*",pericos), collapse=", ")
        ),
        append = TRUE)
    listo <- listo+1
  }
  if (NMcode %in% scr.NM$NM) {
    scarabs <- filter(scr.NM,NM %in% NMcode) %>% distinct(val) %>% pull
    if ("Oxysternon festivum" %in% scarabs) {
      cat(file=archivo,
          "En esta región está presente el escarabajo *Oxysternon festivum* [@Ferrer_Paris_2016].\n\n",
          append = TRUE)
      listo <- listo+1
    }
    if ("Eurysternus impressicollis" %in% scarabs) {
      cat(file=archivo,
          "En esta región está presente el escarabajo *Eurysternus impressicollis* [@ferrer-paris_et_al_E_impressicolis_2023].\n\n",
          append = TRUE)
      listo <- listo+1
    }
    
    if ("Digitonthophagus gazella" %in% scarabs) {
      cat(file=archivo,
          "En esta región se detecto la presencia de una especie invasora de escarabajo coprófago [@Ferrer_Paris_digitonthophagus_2014].\n\n",
          append = TRUE)
      listo <- listo+1
    }
    
    
  }
  if (NMcode %in% jmp.NM$NM) {
    papilios <- filter(jmp.NM,NM %in% NMcode) %>% distinct(val) %>% pull
    if ("Kricogonia lyside" %in% papilios) {
      cat(file=archivo,
          sprintf("En esta región se detecto la presencia de la mariposas del Guayacán *%s*.\n\n", "Kricogonia lyside"),
          append = TRUE)
      listo <- listo+1
    }
    for (endemica in endemicas) {
      if (endemica %in% papilios) {
        cat(file=archivo,
            sprintf("En esta región se detecto la presencia de la mariposas endémica *%s*.\n\n", endemica),
            append = TRUE)
        listo <- listo+1
      }
    }
      
  }
  
  cat(file=archivo,referencias, append = TRUE)
  cat(sprintf("para la region NM%s %s tenemos %s puntos\n",NMcode,i$Nombre, listo))
  if (!file.exists(archivo_final)) {
    if (listo>2)
      file.rename(archivo, archivo_final)
  }
}
