# Iniciativa para el mapeo de la biodiversidad Neotropical

Pagina web con documentación sobre la Iniciativa para el mapeo de la biodiversidad Neotropical (NeoMapas).


## Datos

Los datos de la NeoMapas están dispersos en varios repositorios diferentes.


```{r}

```

## Añadir una clave de acceso a .Renviron

Primero debemos obtener la clave siguiendo las instrucciones de https://guides.dataverse.org/en/latest/user/account.html

El valor que buscamos aparece en la pestaña API Token.

Luego lo agregamos a nuestro archivo .Renviron

```sh
echo "DATAVERSE_KEY=..."" >> ~/.Renviron
```
Tambien agregamos un valor para DATAVERSE_SERVER en el mismo archivo.