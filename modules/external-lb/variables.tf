variable "health_check_name" {
  description = "Name of the health check"
  type        = string
}

variable "check_interval_sec" {
  description = "Interval between health checks"
  type        = number
  default     = 5
}

variable "timeout_sec" {
  description = "Timeout for health check response"
  type        = number
  default     = 5
}

variable "health_check_port" {
  description = "Port used for health checks"
  type        = number
  default     = 443
}

variable "backend_service_name" {
  description = "Name of the backend service"
  type        = string
}

variable "backend_timeout_sec" {
  description = "Timeout (in seconds) for backend responses"
  type        = number
  default     = 30
}

variable "url_serverles_neg" {
  description = "Self-link of the serverless NEG (Cloud Run / Function)"
  type        = string
}

variable "forwarding_rule_name" {
  description = "Name of the global forwarding rule"
  type        = string
}

variable "project" {
  description = "Project ID where the load balancer resources will be created"
  type        = string
}

variable "region" {
  description = "Region to use for NEG and backend service"
  type        = string
}
/**
variable "enable_ssl" {
  description = "Set to true to enable ssl. If set to 'true', you will also have to provide 'var.ssl_certificates'."
  type        = bool
  default     = false
}

variable "enable_http" {
  description = "Set to true to enable ssl. If set to 'true', you will also have to provide 'var.ssl_certificates'."
  type        = bool
  default     = false
}

variable "ssl_certificate_id" {
  description = "Self-link or ID of the SSL certificate to use"
  type        = string
}
**/