## Uso programático de la API | ¿Cómo realizamos predicciones?

# cargar paquetes
library(httr)
library(jsonlite)

# ingresar a url de la API
url <- 'http://10.90.2.47:3123/docs'

# indicar tipo de modelo: 'modelo_15_clases' o 'modelo_16_clases':
query <- list(tipo_modelo = "modelo_15_clases")

# indicar relatos a clasificar:
body <- list("Iba hablando por telefono y me arrancaron el celular de las manos",
             'ingresaron a mi casa rompuedo la chapa, me amenazaron y robaron joyas')

# realizar el requerimiento:
respuesta <- POST(url,                              # url API
                  path = '/predecir',               # ruta, NO MODIFICAR
                  body = body,                      # relatos a clasificar
                  query = query,                    # modelo
                  encode = "json")

# desenvolvemos las predicciones anidadas JSON de la lista a R
prediccion <- fromJSON(content(respuesta, 'text', encoding = 'UTF-8'))

# revisamos la variable
str(prediccion)

# transformando de caracter a numerico
prediccion$probabilidades <- apply(prediccion$probabilidades, 2, as.numeric) %>%
  as.data.frame()

