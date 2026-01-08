terraform {
  required_version = ">= 1.11.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.18"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5"
    }
  }
}
