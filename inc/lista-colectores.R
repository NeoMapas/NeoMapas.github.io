library(dplyr)
library(sf)
library(tmap)
here::i_am("taxa/Ardaris.qmd")
load(here::here("sandbox","NMppln.rda"))

col_str <- jmp.NM %>% filter(yr %in% 2003:2005) %>% pull(col)
col_str <- jmp.NM %>% filter(yr %in% 2014:2020) %>% pull(col)

colectores <- unlist(lapply(col_str, 
                    function(x) {
                      gsub("\\.","",trimws(strsplit(x,"::")[[1]]))
                    }))
                      
table(colectores)


# los datos de 2010 en adelante no están incluidos en este archivo:
table(jmp.NM$tvn %in% subset(tvn.NM, yr>2014)$tvn)
