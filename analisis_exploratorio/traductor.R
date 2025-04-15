if (!require("dplyr")) install.packages("dplyr", dependencies = TRUE)
if (!require("polyglotr")) install.packages("polyglotr", dependencies = TRUE)
if (!require("cld3")) install.packages("cld3", dependencies = TRUE)
library(dplyr)
library(cld3)
library(polyglotr)

val = read.csv("valencia_unido.csv", sep=',')

val <- val %>%
  mutate(
    cld3 = detect_language(val$comments)
  )
library(polyglotr)

val$comments_translated <- NA

for (fila in 1:nrow(val)) {
  cat(sprintf("Procesando fila %d de %d\n", fila, nrow(val)))  # ← Imprime el progreso
  lang <- val$cld3[fila]
  comment <- val$comments[fila]
  
  
  if (is.na(lang) || is.na(comment) || comment == "") {
    val$comments_translated[fila] <- NA
    next
  }
  
  if (lang == "en") {
    val$comments_translated[fila] <- comment
  } else {
    tryCatch(
      {
        translation <- google_translate(
          comment,
          target_language = "en",
          source_language = lang
        )
        val$translated_comment[fila] <- translation
      }, error = function(e) {
        val$translated_comment[fila] <- NA
        message(sprintf("Error translating row %d: %s", fila, e$message))
      })
  }
}
write.csv(val, "valencia_traducido.csv")
print('Traducción completada con éxito')
