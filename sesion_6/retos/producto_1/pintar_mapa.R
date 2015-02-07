### Para el siguiente fragmento de script, suponemos que:
### - Tienes una variable que se llama tendencias
### - La variable tendencias es un data.frame
### - que el data.frame tiene una columna que se llama tau
### - que el data.frame tiene una columna que se llama pvalue
### - que tiene dos columnas, lat y lng

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

## definimos las coordenadas de los puntos
coordinates(tendencias) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencias)=CRS("+init=epsg:4326")

## partimos los valores de tau en 5 clases
clases <- classIntervals(tendencias$tau, n = 5)
## obtenemos cinco colores para una paleta de colores que se llama "Spectral"
plotclr <- rev(brewer.pal(5, "Spectral"))
## Asociamos los valores de tau a su valor correspondiente
colcode <- findColours(clases, plotclr)

## plot sin tener en cuenta
plot(tendencias, col=colcode, pch=19, cex = .6, main = "Mapa de tendencias")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")

###### Otra forma de pintar el mapa

tendencias$significativa <- ifelse(tendencias$pvalue < 0.05, 1, 2)
## plot sin tener en cuenta
plot(tendencias, col=colcode, pch=c(17, 19)[as.numeric(tendencias$significativa)], cex = .6, main = "Mapa de tendencias")
## mostramos la leyenda
legend("topright", legend=names(attr(colcode, "table")), fill=attr(colcode, "palette"), bty="n")


