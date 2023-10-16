terraform {

  cloud {
    organization = "bogon-shop"

    workspaces {
      name = "bogon-shop"
    }
  }

  terraform {
    required_providers {
      aws = {
        source  = "hashicorp/aws"
        version = "5.21.0"
      }
    }
  }


  required_version = ">= 1.1.0"
}
