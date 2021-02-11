library(shiny)

ui <- fluidPage(
  selectInput("data", "Data Set", c("mtcars", "pressure")),
  checkboxGroupInput("cols", "Columns (select 2)", character(0)),
  plotOutput("plot")
)

server <- function(input, output, session) {
  observe({
    data <- get(input$data, "package:datasets")
    # freeze the access of input$cols until all observers are execuated.

    freezeReactiveValue(input, "cols")
    updateCheckboxGroupInput(session, "cols", choices = names(data))
  })

  output$plot <- renderPlot({
    cols <- input$cols  # this will raise an error if input$cols was frozon
    data <- get(input$data, "package:datasets")

    if (length(cols) == 2) {
      plot(data[[cols[1]]], data[[cols[2]]])
    }
  })
}

shinyApp(ui, server)
