terraform {

  cloud {
    organization = "bogon-shop"

    workspaces {
      name = "bogon-shop"
    }
  }



  required_version = ">= 1.3.0"
}
