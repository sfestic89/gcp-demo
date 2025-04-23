module "gcs_bucket_set" {
  source          = "../modules/cloud-storage" # Path to the module directory
  project_id      = "prj-g-s-festic-s-7e017f72"
  bucket_name_set = ["demo-svless-bucket1", "demo-svless-bucket2", "demo-gcs-cf"]
  bucket_location = "EU"
  storage_class   = "STANDARD"
}

module "pubsub_prod" {
  source     = "../modules/pubsub" # Adjust this path if needed
  project_id = "prj-g-s-festic-s-7e017f72"

  topics = {
    "srvless-data-ing" = {
      name = "srvless-data-ing"
      labels = {
        env = "prod"
      }
    }
  }
  subscriptions = {
    "gcs-events-sub" = {
      name       = "data-ing-events-sub"
      topic_name = "srvless-data-ing"
    }
  }
}

module "gcs_notifications" {
  source         = "../modules/gcs-notifications"
  project_number = "684346440845"
  project_id     = "prj-g-s-festic-s-7e017f72"
  topic_name     = "srvless-data-ing"
  notifications = {
    "gcs-upload-notify" = {
      bucket_name        = "demo-svless-bucket1"
      pubsub_topic       = "projects/prj-g-s-festic-s-7e017f72/topics/srvless-data-ing"
      event_types        = ["OBJECT_FINALIZE"]
      payload_format     = "JSON_API_V1"
      object_name_prefix = ""
      custom_attributes = {
        source = "gcs"
      }
    }
  }
}

module "cloud_functions_pubsub" {
  source     = "../modules/cloud-function"
  project_id = "prj-g-s-festic-s-7e017f72"
  region     = "europe-west3"

  functions = {
    "csv_ingest_bq" = {
      name                  = "csv-gcs-to-bq"
      description           = "Handles uploaded CSVs and writes to BQ"
      runtime               = "python310"
      entry_point           = "entrypoint_handler"
      source_bucket         = "demo-gcs-cf"
      source_object         = "csv_gcs_bq.zip"
      pubsub_topic          = "srvless-data-ing"
      service_account_email = "cloud-fn-svc@prj-g-s-festic-s-7e017f72.iam.gserviceaccount.com"
      memory                = "512Mi"
      timeout_seconds       = 120
      env_vars = {
        BQ_DATASET = "ingestion"
        BQ_TABLE   = "gcs_csv_uploads"
      }
    }
  }
}

module "bigquery" {
  source     = "../modules/bigquery"
  project_id = "prj-g-s-festic-s-7e017f72"

  datasets = {
    ingestion = {
      location = "EU"
      labels   = { env = "prod" }
      friendly_name = "ingestion"
    }
  }

  tables = {
    gcs_csv_uploads = {
      dataset_id      = "ingestion"
    }
  }
}
