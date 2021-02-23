Running Shiny app on Google Cloud Run

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
gcloud builds submit --tag gcr.io/$PROJECTID/shinyrun
# change memory need for large project
gcloud run deploy --image gcr.io/$PROJECTID/shinyrun --platform managed --max-instances 1 --memory 1G
```
