# GKE Cluster resource
resource "google_container_cluster" "cluster" {
  provider = google-beta

  name        = var.name
  description = var.description

  project    = var.project_id
  location   = var.location
  network    = var.network
  subnetwork = var.subnetwork

  logging_service     = var.logging_service
  monitoring_service  = var.monitoring_service
  min_master_version  = var.kubernetes_version
  deletion_protection = false

  node_config {
    machine_type = var.machine_type

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  # Remove the default node pool based on custom_pool_enabled
  remove_default_node_pool = var.custom_pool_enabled

  initial_node_count = 1

  # Private cluster configuration
  private_cluster_config {
    enable_private_endpoint = var.enable_private_endpoint
    enable_private_nodes    = var.enable_private_nodes
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  # IP allocation policy
  ip_allocation_policy {
    cluster_secondary_range_name  = var.cluster_secondary_range_name
    services_secondary_range_name = var.services_secondary_range_name
  }

  # Addons Configuration
  addons_config {
    http_load_balancing {
      disabled = !var.http_load_balancing
    }

    horizontal_pod_autoscaling {
      disabled = !var.horizontal_pod_autoscaling
    }
  }

  # Master authentication
  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  # Workload Identity Federation configuration
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  # Master authorized networks configuration
  dynamic "master_authorized_networks_config" {
    for_each = var.master_authorized_networks_config
    content {
      dynamic "cidr_blocks" {
        for_each = lookup(master_authorized_networks_config.value, "cidr_blocks", [])
        content {
          cidr_block   = cidr_blocks.value.cidr_block
          display_name = lookup(cidr_blocks.value, "display_name", null)
        }
      }
    }
  }
}

# Optional custom node pool
resource "google_container_node_pool" "custom_pool" {
  count = var.custom_pool_enabled ? 1 : 0

  cluster  = google_container_cluster.cluster.name
  project  = var.project_id
  location = var.location

  name = var.custom_pool_name

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    shielded_instance_config {
      enable_secure_boot          = true
      enable_integrity_monitoring = true
    }
  }

  initial_node_count = var.node_count
}
/**
# IAM binding for Workload Identity Federation (using existing service account)
resource "google_service_account_iam_member" "bind_wif_service_account" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${var.sa_email}"
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[default/${var.sa_name}]"
}
**/