# Shiny App with database

There are a few purposes of this repo.

- show you how to access a database from a shiny app
- how to setup CRON job to update the database
- and how to deploy the app to google cloud run

## Access Database

To access a database in Shiny application it is recommended to use the `pool` package.

```r
con <- dbPool(
  RPostgres::Postgres(),
  dbname = "dbname",
  user = "user", password = Sys.getenv("DATABASEPW"), host = host
)
```
where the password `DATABASEPW` is stored in `.Renviron`.


Avoid fetching the data in the global frame. You should fetch the data from the database per session or per user interaction. See app.R and [shiny scope rules](https://shiny.rstudio.com/articles/scoping.html) for details.


## Setup CRON job

It is easy to use GitHub [actions](https://github.com/ucdavis-sta141b-sq-2020/shinydb/actions?query=workflow%3ACRON) to setup a CRON job. Check the files [cron.R](cron.R) and [cron.yaml](.github/workflows/cron.yaml).


1. copy the `cron.yaml` to your repo, put it under `.github/workflows/`
2. copy the file `cron.R` and edit it as needed.
3. add the database password in your github repo settings as follow

![](https://user-images.githubusercontent.com/1690993/83981129-10fe8100-a8d0-11ea-935d-8b0a60d40819.png)


## Deploying Shiny app to Google Cloud Run

- passwords should be stored in `.Renviron`
- you also need the file `Dockerfile`
- the files `.gitignore` and `.gcloudignore` are also important
    - `.gitignore` ensures the password is not exposed to github
    - `.gcloudignore` ensures the password is uploaded to google

### 1. Install gcloud SDK

Link: https://cloud.google.com/sdk/install

### 2. Initializing Cloud SDK

Go to terminal and run the following command and follow the instruction
```
gcloud init
```

### 3. Build and deploy the app

```
PROJECTID=$(gcloud config get-value project)
# Build the image of your shiny app
gcloud builds submit --tag gcr.io/$PROJECTID/shinydb
# Deploy to Google Cloud Run
gcloud run deploy --image gcr.io/$PROJECTID/shinydb --platform managed --max-instances 1 --memory 512M
```
ps: specify a reasonable amount of memory

