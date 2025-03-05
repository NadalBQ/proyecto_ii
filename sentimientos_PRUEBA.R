datos = read.csv('valencia_listings.csv')
View(datos)

reviews = read.csv('valencia_reviews.csv')
View(reviews)

library(dplyr)

# Supongamos que tenemos estas dos tablas
colnames(datos)[colnames(datos) == "id"] <- "listing_id"


# Unir las tablas con left_join
airbnbs_reviews <- left_join(datos, reviews, by = "listing_id")

barrios = subset(airbnbs_reviews, neighbourhood =='MORVEDRE')
# Ver el resultado
View(airbnbs_reviews)

install.packages("syuzhet")  
library(syuzhet)

# Calcular puntajes de sentimiento
sentiment_scores <- get_sentiment(barrios$comments, method = "syuzhet")

# Agregar los resultados al dataframe original
print(prueba)
print(sentiment_scores)

View(reviews)



