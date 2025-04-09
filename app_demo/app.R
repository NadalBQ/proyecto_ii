library(shiny)
source("scripts/prediccion.R")
source("scripts/generar_pdf.R")

ui <- navbarPage("Predicción de Viviendas",

  tabPanel("Inicio",
    fluidPage(
      h2("Bienvenido a la app de análisis de precios de viviendas"),
      p("Navega por las pestañas para predecir precios, ver visualizaciones y generar informes.")
    )
  ),

  tabPanel("Predicción",
    fluidPage(
      sidebarLayout(
        sidebarPanel(
          numericInput("m2", "Metros cuadrados:", value = 70),
          selectInput("distrito", "Distrito:", choices = c("Centro", "Norte", "Sur")),
          actionButton("predecir", "Predecir")
        ),
        mainPanel(
          verbatimTextOutput("resultado"),
          plotOutput("grafico"),
          downloadButton("descargar_pdf", "Descargar Informe PDF")
        )
      )
    )
  ),

  tabPanel("Visualización",
    fluidPage(
      h3("Gráficos de datos de viviendas"),
      plotOutput("grafico_general")
    )
  )
)

server <- function(input, output) {
  modelo <- readRDS("modelos/modelo.rds")

  prediccion <- eventReactive(input$predecir, {
    predecir_precio(input$m2, input$distrito, modelo)
  })

  output$resultado <- renderPrint({
    prediccion()
  })

  output$grafico <- renderPlot({
    generar_grafico(prediccion())
  })

  output$descargar_pdf <- downloadHandler(
    filename = function() {"informe.pdf"},
    content = function(file) {
      generar_pdf(prediccion(), file)
    }
  )

  output$grafico_general <- renderPlot({
    # Gráfico general de ejemplo con datos ficticios
    plot(1:10, (1:10)^2, type = "b", main = "Ejemplo de gráfico general")
  })
}

shinyApp(ui, server)
