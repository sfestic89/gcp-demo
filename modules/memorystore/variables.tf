variable "name" {
  description = "(Required) The ID of the instance or a fully qualified identifier for the instance."
  type        = string
}

variable "redis_version" {
  description = "(Required) The version of Redis software. For a list of available versions, please find https://cloud.google.com/memorystore/docs/redis/supported-versions"
  type        = string
}

variable "project_id" {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "region" {
  description = "(Optional) The region to host the Redis instance in."
  type        = string
  default     = null
}

variable "authorized_network" {
  description = "(Optional) The full name of the Google Compute Engine network to which the instance is connected. If left unspecified, the default network will be used."
  type        = string
  default     = null
}

variable "tier" {
  description = "There are 'BASIC' and 'STANDARD_HA'."
  type        = string
  default     = "BASIC"

  validation {
    condition     = can(regex("^(STANDARD_HA|BASIC)$", var.tier))
    error_message = "Tier needs to be either 'BASIC' or 'STANDARD_HA'."
  }
}

variable "redis_configs" {
  description = "(Optional) The Redis configuration parameters. See (https://cloud.google.com/memorystore/docs/redis/reference/rest/v1/projects.locations.instances#Instance.FIELDS.redis_configs) for details."
  type        = map(any)
  default     = {}
}

variable "display_name" {
  description = "user-provided name for the instance."
  type        = string
  default     = null
}

variable "reserved_ip_range" {
  description = "The IP range of internal addresses that are reserved for this instance."
  type        = string
  default     = null
}

variable "connect_mode" {
  description = "Can be either DIRECT_PEERING or PRIVATE_SERVICE_ACCESS. Default is 'DIRECT_PEERING'."
  type        = string
  default     = "DIRECT_PEERING"

  validation {
    condition     = can(regex("^(DIRECT_PEERING|PRIVATE_SERVICE_ACCESS)$", var.connect_mode))
    error_message = "Connectio_mode needs to be either 'DIRECT_PEERING' or 'PRIVATE_SERVICE_ACCESS'."
  }
}

variable "auth_enabled" {
  description = "If set to true AUTH is enabled on the instance. Default is 'true'."
  type        = bool
  default     = true
}

variable "memory_size_gb" {
  description = "Redis memory size in GiB. Default is '1' GiB."
  type        = number
  default     = 1
}