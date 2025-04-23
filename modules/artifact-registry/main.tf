resource "google_artifact_registry_repository" "repos" {
  for_each = { for repo in var.repositories : repo.repo_id => repo }

  repository_id = each.value.repo_id # Required
  project       = var.project_id     # Required
  location      = each.value.location
  format        = each.value.format

  labels = each.value.labels
  lifecycle {
    prevent_destroy = false
  }
}