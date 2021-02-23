library(DBI)

host <- "35.232.125.254"  # replace it with your server ip

con <- dbConnect(
  RPostgres::Postgres(),
  dbname = "demo",
  user = "postgres", password = Sys.getenv("DATABASEPW"), host = host
)


if (!("table1" %in% dbListTables(con))) {
  # create table if it doesn't exist
  dbWriteTable(
    con,
    "table1",
    data.frame(x = rnorm(10), y = rnorm(10))
  )
}


# randomly generate some data
data <- data.frame(x = rnorm(10), y = rnorm(10))

# update the databse
dbWriteTable(con, "table1", data, overwrite = TRUE)

dbDisconnect(con)
