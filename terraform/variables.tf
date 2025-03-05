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