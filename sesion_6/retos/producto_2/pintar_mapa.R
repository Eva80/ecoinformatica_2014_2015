### Para el siguiente fragmento de script, suponemos que:
### - Tienes una variable que se llama robles
### - La variable robles es un data.frame
### - que el data.frame tiene una columna que se llama pvalue
### - que tiene dos columnas, x e y
### - que tiene una columna que se llama "cluster" que indica a qué cluster pertenece.


## OJO: esta variable debería de estar en vuestro script
## variable con el número de cluster con el que estamos probando
n_cluster <- 3 

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(robles) =~x+y
## definimos el sistema de coordenadas WGS84
proj4string(robles)=CRS("+init=epsg:23030")

## obtenemos n_cluster colores para una paleta de colores que se llama "Spectral", para cada cluster creado
plotclr <- rev(brewer.pal(n_cluster, "Spectral"))

## plot, asignando el color en función del cluster al que pertenece
plot(robles, col=plotclr[robles$cluster], pch=19, cex = .6, main = "Mapa de grupos de roble")


