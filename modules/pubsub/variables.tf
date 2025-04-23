variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "topics" {
  description = "Map of Pub/Sub topics to create"
  type = map(object({
    name   = string
    labels = optional(map(string), {})
  }))
}

variable "subscriptions" {
  description = "Map of Pub/Sub subscriptions to create"
  type = map(object({
    name                  = string
    topic_name            = string
    ack_deadline_seconds  = optional(number, 10)
    retain_acked_messages = optional(bool, false)
    expiration_policy_ttl = optional(string, "604800s")
    push_endpoint         = optional(string, null)
  }))
}