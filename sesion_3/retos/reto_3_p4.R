#Hacer un script que muestre la evolución del NDVI medio para las horas del día

library (raster)

horas <-c('12','13','14','15')  # metemos las horas
valores<-c() # creamos vector para guardar los valores

for(k in horas) # bucle para ir hallando la media de cada hora
{
  # mensaje en consola
  cat(paste("Procesando la hora", k,"\n"))
  
  # guardamos los valores de la hora en imagenes
  imagenes <- list.files(path="./sesion_3/retos/ndvi", full.names = TRUE,recursive=TRUE,
                         pattern=paste("_",k, "..\\.jpg\\.asc$", sep=""))
  
  # creamos raster
  imagen <-stack(imagenes)
  
  # calculamos la media y la vamos guardando en valores en formato tabla
  media <- mean(imagen)
  valores <- rbind(valores, mean(media[]))
}
# mostramos la gráfica
plot(valores)

 
  
