variable "project-id" {
  type        = string
  description = "GCP Project ID"
}

variable "region" {
  type    = string
  default = "us-west1"
}

variable "zone" {
  type    = string
  default = "us-west1-b"
}

variable "name" {
  type    = string
  default = "snapchain"
}

variable "enable_dns" {
  description = "Set to true to enable Google Cloud DNS"
  type        = bool
  default     = false
}

variable "dns-name" {
  type        = string
  description = "Top Level DNS Name"
  default     = ""
}

variable "subdomain" {
  type    = string
  default = "snapchain"
}

variable "dns-config" {
  description = "List of DNS zones and their subdomains"
  type = list(object({
    name       = string
    dns-name   = string
    subdomains = list(string)
  }))
  default = []
}