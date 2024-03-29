terraform {
  required_version = ">= 1.3"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }

  backend "s3" {}
}
