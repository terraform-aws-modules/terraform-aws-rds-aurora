terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.30" # Allows for modules that use the TF SG module that need <3.38.
    }
  }
  required_version = ">= 0.14"
}
