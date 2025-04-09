# Crear modelo de ejemplo
modelo <- lm(precio ~ m2 + distrito, data = data.frame(
  precio = c(150000, 180000, 200000, 130000, 170000, 190000),
  m2 = c(50, 60, 70, 40, 65, 75),
  distrito = factor(c("Centro", "Centro", "Norte", "Sur", "Sur", "Norte"))
))

# Guardar el modelo en la carpeta modelos/
saveRDS(modelo, "modelos/modelo.rds")
