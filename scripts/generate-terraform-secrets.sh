#!/bin/bash

# Function to create an IAM user with the necessary permissions for Terraform
create_terraform_iam_user() {
    local iam_user_name="$1"

    echo "Creating IAM user: $iam_user_name"

    # Create IAM user
    aws iam create-user --user-name "$iam_user_name"

    # Attach policies for Terraform usage
    aws iam attach-user-policy --user-name "$iam_user_name" --policy-arn arn:aws:iam::aws:policy/AdministratorAccess

    # Optionally, you could attach more specific policies:
    # aws iam attach-user-policy --user-name "$iam_user_name" --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess
    # aws iam attach-user-policy --user-name "$iam_user_name" --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
    # aws iam attach-user-policy --user-name "$iam_user_name" --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess
    # aws iam attach-user-policy --user-name "$iam_user_name" --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess

    # Generate access keys for the IAM user
    local access_keys=$(aws iam create-access-key --user-name "$iam_user_name")
    local aws_access_key_id=$(echo "$access_keys" | jq -r '.AccessKey.AccessKeyId')
    local aws_secret_access_key=$(echo "$access_keys" | jq -r '.AccessKey.SecretAccessKey')

    # Output the Access Key ID and Secret Access Key
    echo "Access Key ID: $aws_access_key_id"
    echo "Secret Access Key: $aws_secret_access_key"

    # Provide GitLab CI/CD commands to set the secrets
    echo "Run the following commands in your GitLab CI/CD settings to set up the secrets:"
    echo "gitlab-ci set secret AWS_ACCESS_KEY_ID $aws_access_key_id"
    echo "gitlab-ci set secret AWS_SECRET_ACCESS_KEY $aws_secret_access_key"
}

# Main execution

# Set IAM user name
IAM_USER_NAME="terraform-user"

# Create IAM user and generate access keys
create_terraform_iam_user "$IAM_USER_NAME"
