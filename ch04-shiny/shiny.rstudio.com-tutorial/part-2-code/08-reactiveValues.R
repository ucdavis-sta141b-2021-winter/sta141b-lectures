# 08-reactiveValues

library(shiny)

ui <- fluidPage(
  actionButton(inputId = "norm", label = "Normal"),
  actionButton(inputId = "unif", label = "Uniform"),
  plotOutput("hist")
)

server <- function(input, output) {

  rv <- reactiveValues(data = rnorm(100), x = 1, y = 2, z = 3)

  observeEvent(input$norm, {
    rv$data <- rnorm(100) + rv$data2
    rv$x <- rv$y + 4
  })
  observeEvent(input$unif, {
    rv$data <- runif(100)
  })

  observe({
    print(rv$data)
  })

  output$hist <- renderPlot({
    hist(rv$data)
  })
}

shinyApp(ui = ui, server = server)
