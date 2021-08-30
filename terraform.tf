terraform {
  required_version = ">= 0.15.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.42"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}