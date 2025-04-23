resource "google_service_account" "cloud_fn_sa" {
  account_id   = "cloud-fn-svc"
  display_name = "Cloud Function Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "cloud_fn_sa_role" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.cloud_fn_sa.email}"
}

resource "google_cloudfunctions2_function" "module_function" {
  for_each = var.functions

  name        = each.value.name
  description = lookup(each.value, "description", null)
  location    = var.region
  project     = var.project_id

  build_config {
    runtime     = each.value.runtime
    entry_point = each.value.entry_point

    environment_variables = {
      GOOGLE_FUNCTION_SOURCE = "main.py"  # Specify the path to the function file if it's in a subdirectory
    }

    source {
      storage_source {
        bucket = each.value.source_bucket
        object = each.value.source_object
      }
    }
  }

  service_config {
    available_memory      = lookup(each.value, "memory", "256Mi")
    timeout_seconds       = lookup(each.value, "timeout_seconds", 60)
    environment_variables = lookup(each.value, "env_vars", {})
    ingress_settings      = "ALLOW_INTERNAL_AND_GCLB" # optional
    max_instance_count = 1
    min_instance_count = 0
    service_account_email = each.value.service_account_email
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = "projects/${var.project_id}/topics/${each.value.pubsub_topic}"
    retry_policy   = "RETRY_POLICY_RETRY"
  }
}