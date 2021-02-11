# 05-actionButton

library(shiny)

ui <- fluidPage(
  actionButton("clicks", label = "Click me"),
  sliderInput(inputId = "num",
    label = "Choose a number",
    value = 25, min = 1, max = 100)
)

server <- function(input, output) {
  observeEvent(c(input$clicks, input$num), {
    print(as.numeric(input$clicks))
  })
}

shinyApp(ui = ui, server = server)
