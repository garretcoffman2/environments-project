# Script to install and configure AWS CLI on a Windows machine

# Function to install AWS CLI
function Install-AWSCLI {
    Write-Host "Installing AWS CLI..."
    
    # Download the AWS CLI installer
    $installerPath = "$env:TEMP\AWSCLIV2.msi"
    Invoke-WebRequest -Uri "https://awscli.amazonaws.com/AWSCLIV2.msi" -OutFile $installerPath
    
    # Install AWS CLI
    Start-Process msiexec.exe -ArgumentList "/i", $installerPath, "/quiet", "/norestart" -Wait
    
    # Verify installation
    $awsVersion = aws --version
    if ($awsVersion) {
        Write-Host "AWS CLI installed successfully: $awsVersion"
    } else {
        Write-Host "AWS CLI installation failed."
        exit 1
    }
}

# Function to configure AWS CLI
function Configure-AWSCLI {
    Write-Host "Configuring AWS CLI..."
    
    $awsAccessKeyId = Read-Host "Enter AWS Access Key ID"
    $awsSecretAccessKey = Read-Host "Enter AWS Secret Access Key" -AsSecureString | ConvertFrom-SecureString
    $awsRegion = Read-Host "Enter Default region name (e.g., us-east-1)"
    $awsOutputFormat = Read-Host "Enter Default output format (json, text, table) [json]"
    
    if (-not $awsOutputFormat) {
        $awsOutputFormat = "json"
    }

    aws configure set aws_access_key_id $awsAccessKeyId
    aws configure set aws_secret_access_key $awsSecretAccessKey
    aws configure set region $awsRegion
    aws configure set output $awsOutputFormat

    Write-Host "AWS CLI configured successfully."
}

# Function to verify AWS CLI setup
function Verify-AWSCLISetup {
    Write-Host "Verifying AWS CLI setup..."
    $identity = aws sts get-caller-identity
    if ($identity) {
        Write-Host "AWS CLI is successfully configured and authenticated."
        Write-Host $identity
    } else {
        Write-Host "There was an error with the AWS CLI setup."
    }
}

# Main script execution
Install-AWSCLI
Configure-AWSCLI
Verify-AWSCLISetup
