terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.64"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
  }
}
