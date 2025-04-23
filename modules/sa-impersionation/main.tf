# Create the service account in each project
resource "google_service_account" "service_account" {
  project      = var.target_project
  account_id   = var.service_account_id
  display_name = "GitHub Deploy Service Account"
}

# Apply IAM binding for the Workload Identity User
resource "google_service_account_iam_binding" "wif_binding" {
  service_account_id = "projects/${var.target_project}/serviceAccounts/${google_service_account.service_account.account_id}@${var.target_project}.iam.gserviceaccount.com"
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "principalSet://iam.googleapis.com/${var.github_pool_name}/attribute.repository/${var.github_organisation}/${var.github_repository}",
    "principalSet://iam.googleapis.com/${var.github_pool_name}/attribute.repository_owner/${var.github_organisation}"
  ]
}