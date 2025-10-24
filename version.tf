terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.110.0"

    }
  }
}
