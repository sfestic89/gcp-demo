# Required variables
variable "project_id" {
  description = "GCP project name"
}

# Required variables
variable "network" {
  description = "VPC of the CE"
}

# Required variables
variable "subnetwork" {
  description = "Subnet of the CE"
}

# Optional variables
variable "os_pd_ssd_size" {
  description = "Size of OS disk in GB"
  default     = "10"
}

variable "region" {
  description = "GCP region, e.g. us-east1"
  default     = "europe-west3"
}

variable "zone" {
  description = "GCP region, e.g. us-east1"
  default     = "europe-west3-a"
}

variable "machine_type" {
  description = "GCP machine type"
  default     = "n1-standard-1"
}

variable "ce_name" {
  description = "GCP instance name"
  default     = "bastion-demo"
}

variable "boot_image" {
  description = "image to build instance from in the format: image-family/os. See: https://cloud.google.com/compute/docs/images#os-compute-support"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "startup_script" {
  description = "A startup script passed as metadata"
  default     = "touch /tmp/created_by_terraform"
}

variable "labels" {
  type = map(string)
  default = {
    owner       = "demouser"
    environment = "demo"
    app         = "demo"
    ttl         = "24"
  }
}

variable "public_ip" {
  type    = bool
  default = true
}

variable "num_of_servers" {
  description = "Adjust the qty. of servers and associated OS disks created"
  default     = 1
}

