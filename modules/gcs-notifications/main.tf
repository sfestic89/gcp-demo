resource "google_pubsub_topic_iam_member" "gcs_publisher" {
  project = var.project_id
  topic    = var.topic_name
  role     = "roles/pubsub.publisher"
  member   = "serviceAccount:service-${var.project_number}@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_storage_notification" "gcs_to_pubsub" {
  for_each = var.notifications

  bucket         = each.value.bucket_name
  topic          = each.value.pubsub_topic
  event_types    = each.value.event_types
  payload_format = each.value.payload_format

  object_name_prefix = each.value.object_name_prefix
  custom_attributes  = each.value.custom_attributes
}