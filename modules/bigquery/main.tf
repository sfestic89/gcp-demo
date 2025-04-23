resource "google_bigquery_dataset" "bq-dataset" {
  project    = var.project_id
  for_each = var.datasets

  dataset_id = each.key
  friendly_name = each.value.friendly_name
  location   = each.value.location

  labels = each.value.labels
}

resource "google_bigquery_table" "bq-table" {
  project    = var.project_id
  for_each = var.tables

  dataset_id = each.value.dataset_id
  table_id   = each.key
  deletion_protection = false
}