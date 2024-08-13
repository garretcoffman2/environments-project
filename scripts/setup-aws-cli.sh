#!/bin/bash

# Script to install and configure AWS CLI on a Linux/macOS machine

# Function to install AWS CLI
install_aws_cli() {
    echo "Installing AWS CLI..."
    
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        if command -v brew &>/dev/null; then
            brew install awscli
        else
            echo "Homebrew not found, installing AWS CLI via direct download."
            curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
            sudo installer -pkg AWSCLIV2.pkg -target /
        fi
    else
        echo "Unsupported OS type: $OSTYPE"
        exit 1
    fi

    echo "AWS CLI installed successfully."
}

# Function to configure AWS CLI
configure_aws_cli() {
    echo "Configuring AWS CLI..."
    
    read -p "Enter AWS Access Key ID: " aws_access_key_id
    read -sp "Enter AWS Secret Access Key: " aws_secret_access_key
    echo ""
    read -p "Enter Default region name (e.g., us-east-1): " aws_region
    read -p "Enter Default output format (json, text, table) [json]: " aws_output_format

    aws_output_format=${aws_output_format:-json}

    aws configure set aws_access_key_id "$aws_access_key_id"
    aws configure set aws_secret_access_key "$aws_secret_access_key"
    aws configure set region "$aws_region"
    aws configure set output "$aws_output_format"

    echo "AWS CLI configured successfully."
}

# Function to verify AWS CLI setup
verify_aws_cli_setup() {
    echo "Verifying AWS CLI setup..."
    aws sts get-caller-identity
    if [ $? -eq 0 ]; then
        echo "AWS CLI is successfully configured and authenticated."
    else
        echo "There was an error with the AWS CLI setup."
    fi
}

# Main script execution
install_aws_cli
configure_aws_cli
verify_aws_cli_setup