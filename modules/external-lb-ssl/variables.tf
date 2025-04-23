variable "project" {
  description = "The Google Cloud project ID."
  type        = string
}

variable "domain_name" {
  description = "The domain name for the managed SSL certificate (e.g., 'myapp.example.com')."
  type        = string
}

variable "backend_service_name" {
  description = "The name of the backend service."
  type        = string
}

variable "url_serverles_neg" {
  description = "The URL of the serverless NEG (Network Endpoint Group) for Cloud Run."
  type        = string
}

variable "iap_client_id_secret_version" {
  description = "The secret version for the IAP client ID stored in Secret Manager."
  type        = string
  default     = "iap-cloud-run-svc2"
}

variable "iap_client_secret_secret_version" {
  description = "The secret version for the IAP client secret stored in Secret Manager."
  type        = string
  default     = "iap-cloud-run-svc2"
}

variable "members" {
  description = "Allow member for IAP access"
  type        = list(string)
}
