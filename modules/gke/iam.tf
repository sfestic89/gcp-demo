resource "google_project_iam_member" "gke_cluster_admin" {
  project = var.project_id
  role    = "roles/container.admin"
  member  = "user:${var.user_email}"
}

resource "google_project_iam_member" "gke_viewer" {
  project = var.project_id
  role    = "roles/container.viewer"
  member  = "user:${var.user_email}"
}