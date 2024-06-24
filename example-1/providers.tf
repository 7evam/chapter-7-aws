# Initialises Terraform providers and sets their version numbers.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                   = "us-east-2"
  shared_credentials_files = ["/Users/YOUR USER NAME/.aws/credentials"]
  profile                  = "YOUR PROFILE (if necessary)"
}
