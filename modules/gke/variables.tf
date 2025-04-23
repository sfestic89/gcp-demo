variable "name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "description" {
  description = "A description of the GKE cluster"
  type        = string
  default     = ""
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "location" {
  description = "The region or zone for the GKE cluster"
  type        = string
}

variable "network" {
  description = "The VPC network for the cluster"
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork for the cluster"
  type        = string
}

variable "logging_service" {
  description = "The logging service for the cluster"
  type        = string
}

variable "monitoring_service" {
  description = "The monitoring service for the cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "The Kubernetes version for the cluster"
  type        = string
}

variable "enable_private_endpoint" {
  description = "Whether to enable the private endpoint"
  type        = bool
  default     = false
}

variable "master_authorized_networks_config" {
  description = "Add list of subnets that can access the GKE cluster privately."
  type        = list(any)
  default     = []
}

variable "enable_private_nodes" {
  description = "Whether to enable private nodes"
  type        = bool
  default     = false
}

variable "master_ipv4_cidr_block" {
  description = "The CIDR block for the master's IP"
  type        = string
  default     = "172.16.0.0/28"
}

variable "cluster_secondary_range_name" {
  description = "The name of the secondary range for pods"
  type        = string
}

variable "services_secondary_range_name" {
  description = "The name of the secondary range for services"
  type        = string
}

variable "http_load_balancing" {
  description = "Whether HTTP load balancing is enabled"
  type        = bool
  default     = true
}

variable "horizontal_pod_autoscaling" {
  description = "Whether horizontal pod autoscaling is enabled"
  type        = bool
  default     = true
}

variable "resource_labels" {
  description = "Labels to apply to the cluster"
  type        = map(string)
  default     = {}
}

variable "user_email" {
  description = "The email of the user for IAM bindings"
  type        = string
}

variable "custom_pool_name" {
  description = "Flag to enable custom node pool and remove default node pool"
  type        = string
  default     = false
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
  default     = 1
}

variable "machine_type" {
  description = "Flag to enable custom node pool and remove default node pool"
  type        = string
  default     = "e2-small"
}
variable "custom_pool_enabled" {
  description = "Flag to enable custom node pool and remove default node pool"
  type        = bool
  default     = true
}
/**
#variable "service_account_email" {
#  description = "The full email of the service account."
#  type        = string
#}

variable "sa_name" {
  description = "The name of the service account"
  type        = string
}

variable "sa_email" {
  description = "The ID of the service account"
  type        = string
}
**/