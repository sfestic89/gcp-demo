variable "organization_id" {
  description = "The GCP Organization ID"
  type        = string
}

variable "policy_title" {
  description = "Title of the Access Policy"
  type        = string
  default     = "Custom Access Policy"
}
/**
variable "perimeter_name" {
  description = "Name of the VPC-SC perimeter"
  type        = string
}

variable "description" {
  description = "Description of the perimeter"
  type        = string
  default     = "Terraform-managed VPC-SC perimeter"
}

variable "project_numbers" {
  description = "List of project numbers to include in the perimeter"
  type        = list(string)
}

variable "restricted_services" {
  description = "List of GCP services to restrict"
  type        = list(string)
  default     = [
    "bigquery.googleapis.com",
    "storage.googleapis.com"
  ]
}

variable "access_levels" {
  description = "Optional list of access levels"
  type        = list(string)
  default     = []
}

variable "access_policy" {
  description = "Optional list of access levels"
  type        = string
}

variable "allowed_vpc_services" {
  description = "Optional list of allowed services via VPC access"
  type        = list(string)
  default     = []
}

variable "enable_vpc_restriction" {
  description = "Enable restriction for VPC accessible services"
  type        = bool
  default     = false
}
**/