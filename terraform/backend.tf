terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "remote" {
    organization = "standard-crypto"
    workspaces {
      name = "snapchain"
    }
  }

}
