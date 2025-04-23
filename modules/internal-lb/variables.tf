variable "region" {
  description = "The region where resources will be created."
  type        = string
}

variable "project" {
  description = "The project id where the backend will be created."
  type        = string
}

variable "network" {
  description = "The network where the internal load balancer will be deployed."
  type        = string
}

variable "subnetwork" {
  description = "The subnetwork where the internal load balancer will be deployed."
  type        = string
}

variable "health_check_name" {
  description = "The name of the health check."
  type        = string
}

variable "health_check_port" {
  description = "The port for TCP health check."
  type        = string
}

variable "check_interval_sec" {
  description = "The check interval in seconds for the health check."
  type        = number
  default     = 1
}

variable "timeout_sec" {
  description = "The timeout in seconds for the health check."
  type        = number
  default     = 1
}

variable "backend_service_name" {
  description = "The name of the backend service."
  type        = string
}

variable "backend_timeout_sec" {
  description = "The timeout in seconds for the backend service."
  type        = number
  default     = 10
}

variable "forwarding_rule_name" {
  description = "The name of the forwarding rule."
  type        = string
}

variable "url_serverles_neg" {
  description = "The name of the serverless NEG"
  type        = string
}

variable "svc_attachment_name" {
  description = "The list of ports for the forwarding rule."
  type        = string
}

variable "proxy_protocol" {
  description = "True if proxy protocol is used."
  type        = bool
}

variable "nat_subnets" {
  description = "True if proxy protocol is used."
  type        = list(string)
}

variable "consumer_endpoint_name" {
  description = "True if proxy protocol is used."
  type        = string
}

variable "endpoint_network" {
  description = "True if proxy protocol is used."
  type        = string
}

variable "consumer_project" {
  description = "True if proxy protocol is used."
  type        = string
}