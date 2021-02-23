library(shiny)
library(tidyverse)
library(lubridate)
library(pool)

host <- "35.232.125.254"  # replace it with your server ip

# for shiny application, it is recommended to use "pool" over "DBI"
# "pool" automatically handles multiple concurrent connections for us.
# the functionality of "pool" is basically the same as that of "DBI".

con <- dbPool(
  RPostgres::Postgres(),
  dbname = "demo",
  user = "postgres", password = Sys.getenv("DATABASEPW"), host = host
)

onStop(function() poolClose(con))


ui <- fluidPage(

  titlePanel("Hello Shiny!"),

  sidebarLayout(

    sidebarPanel(
      sliderInput("obs", "No. of random observations:",
                  min = 1, max = 10, value = 5)
    ),

    mainPanel(
      tableOutput("table1")
    )
  )
)

server <- function(input, output) {
  # read the table for the database per session

  # read the whole table
  data <- tbl(con, "table1") %>% collect()

  # alternative, you could put then in a reactive expression and only fetch the
  # required data
  # data <- reactive({
  #   tbl(con, "table1") %>% collect() %>% head(input$obs)
  # })

  output$table1 <- renderTable({

    data %>% head(input$obs)

    # if reactive expression is used
    # data()
  })
}

shinyApp(ui = ui, server = server)
