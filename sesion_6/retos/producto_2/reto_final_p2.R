#Cargamos libreria raster 
library(raster)
# Leer archivo
archivo_robles<-read.csv("./sesion_6/retos/producto_2/robles_ecoinfo.csv", header = T, sep = ",", dec=".")
# elimino las dos primeras columnas
robles_1 <- archivo_robles[,3:33]
## variable con el número de cluster con el que estamos probando
n_cluster <- 3 
# cluster con 3 clases, un numero maximo de 200 iteracciones y 3 centroides 
robles_cluster <- kmeans (robles_1, n_cluster, iter.max = 200, nstart = 3)
# cluster de los valores obtenidos despues de la clasificacion
cluster <- robles_cluster$cluster
# creamos un data.frame siendo columnas los x,y del archivo original y el cluster calculado
robles <- data.frame(archivo_robles$x,archivo_robles$y,cluster)
# cambiamos de nombre a las columnas
names(robles) <- c('x','y','cluster')

################### 3º PINTAR MAPA #########################################################

### Para el siguiente fragmento de script, suponemos que:
### - Tienes una variable que se llama robles
### - La variable robles es un data.frame
### - que el data.frame tiene 
### -  dos columnas, x e y
### -  una columna que se llama "cluster" que indica a qué cluster pertenece.

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
pdf(file="mi_pdf2.pdf",height=8,width=10)
## plot, asignando el color en función del cluster al que pertenece
plot(robles, col=plotclr[robles$cluster], pch=19, cex = .6, main = "Mapa de grupos de roble")
dev.off()

