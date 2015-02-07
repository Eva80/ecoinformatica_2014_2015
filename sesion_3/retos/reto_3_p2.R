#Algoritmo que dado un umbral por el usuario, dados 10 números por el usuario, cuente cuántos de esos números supera el umbral indicado

# Opción1) Se crean las variables a partir de unos valores
numeros<-c(11,5,8,6,5,4,7,9,21,3)
umbral<-8   

# Opción2) Se introduce los valores por consola 
#numeros<-scan(n=10)
#umbral<-scan(n=1)

contador<-0 # ponemos contador a cero. nos va a decir cuántos de esos números supera el umbral
k<-1        # variable para recorrer los números

for(k in numeros) # bucle para ir uno a uno viendo los números
{
  if(k>umbral) # si un número está por encima del umbral
  {
   contador<-contador+1   # añadimos 1 al contador
  }  
}
print (contador)
#debe salir contador=3 (con los valores de números de arriba)

