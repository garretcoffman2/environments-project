provider "aws" {
  region = "us-west-1"  # Specifies the AWS region where resources will be created.
}

# Creates separate S3 buckets for Terraform state files for each environment.
resource "aws_s3_bucket" "terraform_state_bucket" {
  count = 3  # Create one bucket for each environment (development, staging, production)

  bucket = "${lower("environments-project-${element(["development", "staging", "production"], count.index)}-terraform-state")}"
  acl    = "private"  # Ensure the bucket is private

  versioning {
    enabled = true  # Enable versioning to keep track of changes to the state file
  }

  tags = {
    Name        = "${element(["development", "staging", "production"], count.index)}-terraform-state"
    Environment = element(["development", "staging", "production"], count.index)  # Tag the bucket with the environment
  }
}

# Creates separate DynamoDB tables for state locking for each environment.
resource "aws_dynamodb_table" "terraform_state_lock" {
  count = 3  # Create one DynamoDB table for each environment

  name         = "${lower("environments-project-${element(["development", "staging", "production"], count.index)}-terraform-lock")}"
  billing_mode = "PROVISIONED"  # Use provisioned throughput for consistent performance

  attribute {
    name = "LockID"  # The attribute used by Terraform to manage state locks
    type = "S"  # Type is String
  }

  key_schema {
    attribute_name = "LockID"  # Set LockID as the primary key
    key_type       = "HASH"  # Define as a hash key
  }

  provisioned_throughput {
    read_capacity  = 5  # Set read capacity units
    write_capacity = 5  # Set write capacity units
  }

  tags = {
    Name        = "${element(["development", "staging", "production"], count.index)}-terraform-lock"
    Environment = element(["development", "staging", "production"], count.index)  # Tag the table with the environment
  }
}
