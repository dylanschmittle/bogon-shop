terraform {
  required_version = ">= 1.3.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.7.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.7.1"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.0"
    }
  }
}
