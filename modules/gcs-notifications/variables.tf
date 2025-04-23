variable "project_number" {
  type = string
}

variable "project_id" {
  type = string
}

variable "topic_name" {
  type = string
}

variable "notifications" {
  description = "Map of GCS → Pub/Sub notifications"
  type = map(object({
    bucket_name         = string
    pubsub_topic        = string
    event_types         = list(string)
    payload_format      = string
    object_name_prefix  = optional(string, null)
    custom_attributes   = optional(map(string), {})
  }))
}