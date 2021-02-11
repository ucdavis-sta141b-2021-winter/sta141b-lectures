library(shiny)

ui <- fluidPage(
  sliderInput("n", label = "Number of observation", value = 25, min = 1, max = 100),
  plotOutput("p")
)

server <- function(input, output) {
  output$p <- renderPlot({
    hist(runif(input$n))
  })
}

shinyApp(ui = ui, server = server)
