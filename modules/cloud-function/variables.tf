variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "Region for deployment"
  type        = string
  default     = "europe-west1"
}

variable "functions" {
  description = "Map of Cloud Function configurations"
  type = map(object({
    name             = string
    description      = optional(string)
    entry_point      = string
    runtime          = string
    source_bucket    = string
    source_object    = string
    pubsub_topic     = string
    service_account_email = string
    memory           = optional(string)
    timeout_seconds  = optional(number)
    env_vars         = optional(map(string))
  }))
}