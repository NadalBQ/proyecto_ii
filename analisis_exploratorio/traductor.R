library(readr)
library(textcat)
library(httr)
library(jsonlite)

# Función para leer un archivo de texto
get_file_text <- function(address) {
  read_file(address)
}

# Función para traducir un texto con LibreTranslate (software libre)
traducir_texto <- function(texto, source_lang = "auto", target_lang = "en") {
  url <- "https://libretranslate.com/translate"  # Puedes cambiar a otro servidor si está caído
  body <- list(
    q = texto,
    source = source_lang,
    target = target_lang,
    format = "text"
  )
  
  response <- tryCatch({
    res <- POST(url, body = body, encode = "json", content_type("application/json"))
    json_res <- fromJSON(content(res, "text"))
    return(json_res$translatedText)
  }, error = function(e) {
    print("Errroooooooor")
    return(texto) # Si falla la traducción, devuelve el texto original
  })
  
  return(response)
}

# Función para detectar si el texto está en inglés
is_english <- function(text) {
  lang <- textcat(text)
  return(lang == "english")
}

# Función para detectar si el texto está en español
is_spanish <- function(text) {
  lang <- textcat(text)
  return(lang == "spanish")
}

# Función principal de traducción
traducir <- function(csv_address = "valencia_reviews.csv", 
                     nombre_columna = "comments", 
                     destino = "en_reviews.txt", 
                     i = 1, 
                     amount = -1) {
  
  # Leer CSV
  csv <- read_csv(csv_address, show_col_types = FALSE)
  
  # Obtener comentarios
  comentarios <- csv[[nombre_columna]]
  com <- i
  top <- i + amount
  count_spanish <- 0
  errores <- c()
  
  if (amount < 0) {
    amount <- length(comentarios)
  }
  
  # Traducir comentarios
  while (i <= length(comentarios)) {
    comentario <- as.character(comentarios[i])
    i <- i + 1
    
    spanish <- is_spanish(comentario)
    if (spanish) {
      count_spanish <- count_spanish + 1
    }
    
    if (!is_english(comentario)) {
      comentario <- traducir_texto(comentario)
    }
    
    print(i)
    
    # Guardar en archivo
    tryCatch({
      write(paste0(comentario, "¿", spanish, "¿", i, "\n"), 
            file = destino, append = TRUE)
    }, error = function(e) {
      errores <- c(errores, i)
    })
    
    if (i == top) {
      break
    }
  }
  
  return(list(comienzo = com, fin = i, errores = errores, total_spanish = count_spanish))
}

# Medir tiempo de ejecución
start_time <- Sys.time()
print(traducir())
end_time <- Sys.time()
print(paste("Tiempo total:", end_time - start_time))
