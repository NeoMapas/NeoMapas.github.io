# Descargadas de internet
# personas/gustavo.jpg

# enlazadas desde alguna dirección web
#Personas/Ada

# Encontradas en nuestros respaldos, aunque no recuerdo de donde
# personas/JR-en-Araya.jpg

## Disponibles en el respaldo en gaia.ad.unsw.edu.au
<<<<<<< HEAD
convert NeoMapas_imagenes/Ardaris/00_GavetaOrdenada.jpg -resize 400x400 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Ardaris-gaveta-ordenada.jpg
convert NeoMapas_imagenes/CatastictaRevancha.png -resize 400x400 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Catasticta-revancha.jpg

## Disponibles en Teradactylo
FOTOTECA=/Volumes/Teradactylo/Fototeca
PRYDIR=~/proyectos/NeoMapas/NeoMapas.github.io

## Personas
FOTODIR=Ordenados/2008/01/b08_27Enero2008
convert $FOTOTECA/$FOTODIR/00094.jpg -resize 800x800 $PRYDIR/personas/JR.jpg

FOTODIR=Ordenados/2005/08/Guri2
convert $FOTOTECA/$FOTODIR/pict0046.jpg -resize 800x800 $PRYDIR/personas/Tatjana.jpg
convert $FOTOTECA/$FOTODIR/pict0063.jpg -resize 400x400 $PRYDIR/personas/Ada.jpg
FOTODIR=Ordenados/2008/09/BiodiVen
convert $FOTOTECA/$FOTODIR/ColeccionIVIC035.JPG -shave 0x200 -resize 600x600  $PRYDIR/personas/Solis.jpg


FOTODIR=Colecciones/Salidas-Campo/
PRYDIR=~/proyectos/NeoMapas/NeoMapas.github.io
mkdir -p $PRYDIR/NM/fotos/

#NM45
convert $FOTOTECA/$FOTODIR/2009_06_16-Mapire/IMG_6693.png -resize 800x800 $PRYDIR/NM/fotos/NM45.jpg
convert $FOTOTECA/$FOTODIR/2009_06_15/IMG_6622.png -resize 800x800 $PRYDIR/NM/fotos/NM45-alt.jpg

#NM28
convert $FOTOTECA/$FOTODIR/Via_Cueva_del_Toro/P1260002.JPG -resize 800x800 $PRYDIR/NM/fotos/NM28.jpg
convert $FOTOTECA/$FOTODIR/Via_Cueva_del_Toro/P1260031.JPG -resize 800x800 $PRYDIR/NM/fotos/NM28-alt.jpg
convert $FOTOTECA/$FOTODIR/Via_Cueva_del_Toro/P1260023.JPG -resize 800x800 $PRYDIR/NM/fotos/NM28-veg.jpg

FOTODIR=NoOrdenado/00_Viajes_TrabajoCursos/FotosFalcon/
$FOTOTECA/$FOTODIR/

## upload to inat:
exiftool $FOTOTECA/$FOTODIR/Foto20041002141354.JPG

=======
convert NeoMapas_imagenes/Ardaris/00_GavetaOrdenada.jpg -resize 500x500 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Ardaris-gaveta-ordenada.jpg
convert NeoMapas_imagenes/CatastictaRevancha.png -resize 500x500 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Catasticta-revancha.jpg
convert NeoMapas_imagenes/dgazella/Fig1_Digitonthophagus_gazella.png -resize 600x600 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Digitonthophagus-gazella.jpg
convert NeoMapas_imagenes/ColecciónNeoMapas/ColeccionNeoMapas2.png -resize 500x500 ~/proyectos/NeoMapas/NeoMapas.github.io/taxa/Oxysternon-festivum.jpg
>>>>>>> 780e64c026179fe34edc9fc924ac28c9f380b1c9
