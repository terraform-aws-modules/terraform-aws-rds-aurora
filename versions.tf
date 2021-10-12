terraform {
  required_version = ">= 0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.30"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 2.2"
    }
  }
}
