
## cargamos librerias
library('Kendall') 
library(raster)

################## 1er ARCHIVO  ##########################################################

# leemos los datos 1er archivo
datos_ndvi <- read.csv("/home/evagibaja/ecoinformatica_2014_2015/sesion_6/retos/producto_1/ndvi_robledal.csv", sep = ";")
# data frame inicial vacio para acumular los resultados
datos_1 <- data.frame()
# organizar los datos por pixeles
datos_ndvi_o<-datos_ndvi[order(datos_ndvi$iv_malla_modi_id),]
# vector para extraer los pixeles y devolver el listado de ids únicos 
pixeles<-unique(datos_ndvi_o$iv_malla_modi_id) 
# Bucle que recorra todos los identificadores de pixels,
# y para cada pixel, calcular el mannkendall
for(k in pixeles)
{
  # extraer datos correspondientes al pixel 
  datos_ndvi_id <- datos_ndvi_o[datos_ndvi_o$iv_malla_modi_id == k,] 
  # calcular la tendencia
  m <- MannKendall(datos_ndvi_id$ndvi_i)
  # crear un data frame con la estructura necesaria para pintar mapa
  datos_pixel<-data.frame(tau=m[1]$tau[1],pvalue=m[2]$sl[1],lat=datos_ndvi_id$lat[1],lng=datos_ndvi_id$lng[1])
  # concatenar el data frame que acumula con el data frame del pixel que se ha creado
  datos_1 <- rbind(datos_1, datos_pixel)  
}

################## 2º ARCHIVO  ##########################################################

## leemos los datos 2º archivo
datos_nieve <- read.csv("/home/evagibaja/ecoinformatica_2014_2015/sesion_6/retos/producto_1/nieve_robledal.csv", sep = ";")
# data frame inicial vacio para acumular los resultados
datos_2 <- data.frame()
# organizar los datos por pixeles
datos_nieve_o<-datos_nieve[order(datos_nieve$nie_malla_modi_id),]
# vector para extraer los pixeles y devolver el listado de ids únicos 
pixeles<-unique(datos_nieve_o$nie_malla_modi_id) 
# Bucle que recorra todos los identificadores de pixels,
# y para cada pixel, calcular el mannkendall
for(k in pixeles)
{
  # extraer datos correspondientes al pixel 
  datos_nieve_id <- datos_nieve_o[datos_nieve_o$nie_malla_modi_id == k,] 
  # calcular la tendencia
  m <- MannKendall(datos_nieve_id$scd)  
  # crear un data frame con la estructura necesaria para pintar mapa
  datos_pixel<-data.frame(tau=m[1]$tau[1],pvalue=m[2]$sl[1],lat=datos_nieve_id$lat[1],lng=datos_nieve_id$lng[1])
  # concatenar el data frame que acumula con el data frame del pixel que se ha creado
  datos_2 <- rbind(datos_2, datos_pixel)
}


################### 3º PINTAR MAPA #########################################################

library(sp)
library(rgdal)
library(classInt)
library(RColorBrewer)

tendencias_1<-datos_1
tendencias_2<-datos_2
## definimos las coordenadas de los puntos
coordinates(tendencias_1) =~lng+lat
coordinates(tendencias_2) =~lng+lat
## definimos el sistema de coordenadas WGS84
proj4string(tendencias_1)=CRS("+init=epsg:4326")
proj4string(tendencias_2)=CRS("+init=epsg:4326")
## partimos los valores de tau en 5 clases
clases_1 <- classIntervals(tendencias_1$tau, n = 5)
clases_2 <- classIntervals(tendencias_2$tau, n = 5)
## obtenemos cinco colores para una paleta de colores que se llama "Spectral"
plotclr_1 <- rev(brewer.pal(5, "Spectral"))
plotclr_2 <- rev(brewer.pal(5, "Spectral"))
## Asociamos los valores de tau a su valor correspondiente
colcode_1 <- findColours(clases_1, plotclr_1)
colcode_2 <- findColours(clases_2, plotclr_2)
pdf(file="mi_pdf.pdf",height=8,width=10)
# para ver dos gráficos
par(mfrow=c(1,2))
## plot 
plot(tendencias_1, col=colcode_1, pch=19, cex = .6, main = "Mapa de tendencias 1")
legend("topright", legend=names(attr(colcode_1, "table")), fill=attr(colcode_1, "palette"), bty="n")
## plot 
plot(tendencias_2, col=colcode_2, pch=19, cex = .6, main = "Mapa de tendencias 2")
legend("topright", legend=names(attr(colcode_2, "table")), fill=attr(colcode_2, "palette"), bty="n")
dev.off()

getwd()



