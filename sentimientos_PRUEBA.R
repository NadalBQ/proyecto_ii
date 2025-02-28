datos = read.csv('valencia_listings.csv')
View(datos)

reviews = read.csv('valencia_reviews.csv')
View(reviews)

# Filtrar filas donde host_name es "Antonio"
subset(datos, host_name == "Antonio")
prueba = subset(reviews, )
  

# Alternativamente, usando indexación lógica
datos[datos$host_name == "Antonio", ]

prueba = subset(reviews, reviewer_name == 'Rachel')
print(prueba)

library(dplyr)

# Supongamos que tenemos estas dos tablas
colnames(datos)[colnames(datos) == "id"] <- "listing_id"


# Unir las tablas con left_join
airbnbs_reviews <- left_join(datos, reviews, by = "listing_id")

barrios = subset(airbnbs_reviews, neighbourhood =='MORVEDRE')
# Ver el resultado
View(airbnbs_reviews)

install.packages("googleLanguageR")
library(googleLanguageR)

# Configura tu clave API de Google Cloud
gl_auth("path_to_your_google_cloud_credentials.json")

# Traducir las *reviews* a inglés
reviews_df$review_en <- gl_translate(reviews_df$review, target = "en")$translatedText

install.packages("syuzhet")  
library(syuzhet)

# Calcular puntajes de sentimiento
sentiment_scores <- get_sentiment(barrios$comments, method = "syuzhet")

# Agregar los resultados al dataframe original
print(prueba)
print(sentiment_scores)

View(reviews)



