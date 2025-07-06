terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "shakedkattan-tfstate-bucket"
    key    = "prod/ec2.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}
