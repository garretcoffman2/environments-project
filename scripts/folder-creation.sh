#!/bin/bash

# Create the main project directory
mkdir -p environments-project

# Create the modules directory and its subdirectories
mkdir -p environments-project/modules/{vpc,k8s,monitoring}

# Create the global directory
mkdir -p environments-project/global

# Create environment-specific directories
mkdir -p environments-project/{development,staging,production}

# Create the .github/workflows directory
mkdir -p environments-project/.github/workflows

# Create placeholder files for modules
echo "# VPC Module" > environments-project/modules/vpc/main.tf
echo "# Kubernetes (EKS) Module" > environments-project/modules/k8s/main.tf
echo "# Monitoring (Grafana & Prometheus) Module" > environments-project/modules/monitoring/main.tf

# Create placeholder file for global configuration
echo "# Global Configuration (S3 Buckets)" > environments-project/global/main.tf

# Create placeholder files for each environment
for env in development staging production; do
    echo "# Main Terraform configuration for $env environment" > environments-project/$env/main.tf
    echo "# Variables for $env environment" > environments-project/$env/variables.tf
