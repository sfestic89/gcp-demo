variable "project_id" {
  description = "The ID of the project where the IAP configuration will be created."
  type        = string
}

variable "client_display_name" {
  description = "The display name for the OAuth client."
  type        = string
}

variable "support_email" {
  description = "The support email for the IAP Brand."
  type        = string
}

variable "application_title" {
  description = "The application title for the IAP Brand."
  type        = string
}

variable "backend_service_name" {
  description = "The name of the backend service for which IAP will be enabled."
  type        = string
}

variable "members" {
  description = "The list of members to be granted the IAP access role."
  type        = list(string)
}
