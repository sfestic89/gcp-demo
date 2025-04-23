# Cluster name output
output "cluster_name" {
  description = "The name of the GKE cluster."
  value       = google_container_cluster.cluster.name
}

# Kubernetes endpoint output
output "kubernetes_endpoint" {
  description = "The endpoint of the GKE cluster."
  value       = google_container_cluster.cluster.endpoint
}

# Cluster project ID
output "project_id" {
  description = "The project ID where the GKE cluster is created."
  value       = google_container_cluster.cluster.project
}

# Cluster zone or region
output "cluster_location" {
  description = "The location (region or zone) of the GKE cluster."
  value       = google_container_cluster.cluster.location
}

# Private cluster configuration (if enabled)
output "private_cluster_config" {
  description = "The private cluster configuration details."
  value       = google_container_cluster.cluster.private_cluster_config
}

# The node pool configuration (if applicable)
output "node_pool_config" {
  description = "The node pool configuration details."
  value       = google_container_cluster.cluster.node_pool
}