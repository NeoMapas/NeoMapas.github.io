# Datos de NeoMapas

# Creamos una carpeta en donde guardar los archivos descargados de los repositorios.

here::i_am("inc/data-download.R")
dir_datos <- here::here("sandbox")

if (!dir.exists(dir_datos))
  dir.create(dir_datos)

# Los datos de la NeoMapas están dispersos en varios repositorios diferentes.


# Dataverse ----

# Añadir una clave de acceso a .Renviron
# Primero debemos obtener la clave siguiendo las instrucciones de https://guides.dataverse.org/en/latest/user/account.html
# El valor que buscamos aparece en la pestaña API Token.

# Luego lo agregamos a nuestro archivo .Renviron
# Por ejemplo, en un terminal:
# echo "DATAVERSE_KEY=..."" >> ~/.Renviron

# Tambien agregamos un valor para DATAVERSE_SERVER en el mismo archivo.
# echo "DATAVERSE_KEY=dataverse.harvard.edu" >> ~/.Renviron

# Load the dataverse library
library("dataverse")
library(dplyr)
# Option 1: read file directly

gpstrack <- get_dataframe_by_name(
  filename = "05.gpx",
  dataset = "10.7910/DVN/Y1AQKS",
  original = TRUE,
  .f = sf::read_sf)

# Option 2: read binary and save
# let's create our own function
dataverse_download <- function(repo, arch, localdir="sandbox") {
  if (!dir.exists(here::here(localdir)))
    stop("Carpeta inalcanzable")
  destino <- here::here(localdir, arch)
  if (file.exists(destino)) {
    message("Ya existe un archivo con ese nombre/ubicación")
  } else {
    as_binary <- get_file_by_name(
      filename = arch,
      dataset = repo)
    writeBin(as_binary, destino)
  }
}

repositorio <- "10.7910/DVN/Y1AQKS"
for (archivo in c(sprintf("%02d.gpx",c(1:29,34:41,43:45,93:95)))) {
  dataverse_download(repositorio, archivo)
}


repositorio <- "10.7910/DVN/YLZTVZ"
for (archivo in 
  c("Coordenadas-puntos-transectas-NeoMapas.csv",
    "Piñero-Manglarito-coords.csv",
    "Ejemplares-Aves-NM43-Piñero.csv",
    "Ejemplares-Aves-NM95-Piñero-b.csv",
    "Ejemplares-Aves-NM93-Anacoco.csv",
    "Ejemplares-Aves-NM25-Yacambu.csv")) {
  dataverse_download(repositorio, archivo)
}
  


## Pangaea
archivo <- "Amazona-dataset.tab"

download.file("https://doi.pangaea.de/10.1594/PANGAEA.803430?format=textfile",
              here::here("sandbox", archivo))

## datos de los respaldos copiados:
## scp jferrer@gaia.ad.unsw.edu.au:~/respaldo/NeoMapas/Rdata/20150515_NM.rda /Users/z3529065/proyectos/NeoMapas/NeoMapas.github.io/sandbox


load(here::here("sandbox",  "20150515_NM.rda"))
info.NM <- info.NM %>% filter(Nombre != "", !Fecha %in% "0000-00-00")
front.matter <- "---
title: \"NM%s - %s\"
subtitle: \"%s\"
editor_options: 
  chunk_output_type: console
execute:
  echo: false 
  message: false
  warning: false
---

## Basic information 

"

for (j in 1:nrow(info.NM)) {
  i <- info.NM[j,]
  archivo <- here::here("NM",sprintf("NM%02d.qmd",i$NM))
  if (!file.exists(archivo)) {
    cat(file=archivo,
        sprintf(front.matter, i$NM, i$Nombre, i$ADM1))
  }
    print(i$Nombre) 
    cat(file=archivo,paste(sprintf("*%s*: %s",names(i),i),collapse="\n"),append=TRUE)
}
