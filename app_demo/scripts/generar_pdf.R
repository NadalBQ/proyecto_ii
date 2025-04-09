generar_pdf <- function(prediccion, salida) {
  rmarkdown::render(
    input = "reportes/informe.Rmd",
    output_file = salida,
    params = list(pred = prediccion),
    envir = new.env(parent = globalenv())
  )
}
