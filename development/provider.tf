# Configures the AWS provider and backend for Terraform state storage in the development environment.

provider "aws" {
  region = "us-west-1"  # AWS region where resources will be created
}

terraform {
  backend "s3" {
    bucket         = "environments-project-development-terraform-state"  # S3 bucket for storing the Terraform state file
    key            = "terraform.tfstate"  # Path within the bucket where the state file will be stored
    region         = "us-west-1"  # AWS region for the S3 bucket
    encrypt        = true  # Ensure the state file is encrypted
    dynamodb_table = "environments-project-development-terraform-lock"  # DynamoDB table for state locking
  }
}
