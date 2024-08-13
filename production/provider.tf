# Configures the AWS provider and backend for Terraform state storage in the production environment.

provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket         = "environments-project-production-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-west-1"
    encrypt        = true
    dynamodb_table = "environments-project-production-terraform-lock"
  }
}
