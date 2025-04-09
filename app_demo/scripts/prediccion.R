predecir_precio <- function(m2, distrito, modelo) {
  nuevo <- data.frame(m2 = m2, distrito = factor(distrito, levels = levels(modelo$xlevels$distrito)))
  pred <- predict(modelo, newdata = nuevo)
  return(round(pred, 2))
}

generar_grafico <- function(pred) {
  barplot(height = pred,
          names.arg = "Predicción (€)",
          col = "steelblue",
          ylim = c(0, max(pred + 10000)),
          main = "Precio Estimado de la Vivienda")
}
