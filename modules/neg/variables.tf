variable "name" {
  description = "The name of the serverless NEG"
  type        = string
}

variable "region" {
  description = "The region where the NEG will be created"
  type        = string
}

variable "cloud_run_service" {
  description = "The Cloud Run service name to attach to the NEG (optional)"
  type        = string
  default     = null
}

variable "cloud_function" {
  description = "The Cloud Function name to attach to the NEG (optional)"
  type        = string
  default     = null
}

variable "validate_one_service" {
  description = "Ensures that only one of cloud_run_service or cloud_function is set"
  type        = bool
  default     = true
}