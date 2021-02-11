library(shiny)

ui <- fluidPage(
  p("The checkbox group controls the select input"),
  checkboxGroupInput("inCheckboxGroup", "Input checkbox", c("Item A", "Item B", "Item C")),
  selectInput("inSelect", "Select input", c("Item A", "Item B", "Item C"))
)


# to use `updateSelectInput`, the server function will take three parameters.

server <- function(input, output, session) {
  # the observe function is like observeEvent function but it listens to all inputs in the block.
  observe({
    x <- input$inCheckboxGroup
    # Can use character(0) to remove all choices
    if (is.null(x))
      x <- character(0)

    # Can also set the label and select items
    updateSelectInput(session, "inSelect",
      label = paste("Select input label", length(x)),
      choices = x,
      selected = tail(x, 1)
    )
  })
}

shinyApp(ui, server)
