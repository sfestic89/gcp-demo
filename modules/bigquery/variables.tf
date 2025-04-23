variable "project_id" {
  type = string
}

variable "datasets" {
  type = map(object({
    location = string
    friendly_name = string
    labels   = optional(map(string), {})
  }))
}

variable "tables" {
  type = map(object({
    dataset_id      = string
  }))
}