# Environments Project

## Overview

The **Environments Project** is an infrastructure-as-code (IaC) solution that automates the creation, management, and monitoring of development, staging, and production environments on AWS. The project leverages **Terraform** to provision resources such as Virtual Private Clouds (VPCs), Elastic Kubernetes Service (EKS) clusters, and monitoring tools like **Grafana** and **Prometheus**. GitHub Actions workflows are used to deploy, destroy, and rebuild the infrastructure as needed.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
- [Usage](#usage)
  - [Deploying Infrastructure](#deploying-infrastructure)
  - [Destroying Infrastructure](#destroying-infrastructure)
  - [Rebuilding Environments](#rebuilding-environments)
  - [Exposing Grafana Externally](#exposing-grafana-externally)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Modules](#modules)
- [Contributing](#contributing)
- [License](#license)

## Project Structure

```bash
environments-project/
├── scripts/
│   ├── setup-aws-cli.sh
│   ├── setup-aws-cli.ps1
│   └── folder-creation.sh
├── terraform/
│   ├── modules/
│   │   ├── eks/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── s3/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│   ├── environments/
│   │   ├── dev/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── staging/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── production/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
├── .github/
│   ├── workflows/
│   │   ├── terraform-state-bucket.yml
│   │   ├── terraform-state-bucket-destroy.yml
│   │   ├── terraform-runner-deploy.yml
│   │   ├── terraform-runner-destroy.yml
│   │   ├── terraform-monitoring.yml
│   │   ├── terraform-monitoring-destroy.yml
│   │   ├── terraform-deploy-all.yml
│   │   ├── terraform-destroy-all.yml
│   │   ├── terraform-expose-grafana-externally.yml
│   │   ├── terraform-revert-grafana-expose.yml
│   │   ├── terraform-rebuild-development.yml
│   │   ├── terraform-rebuild-staging.yml
│   │   ├── terraform-rebuild-production.yml
│   │   ├── terraform-plan-all.yml
│   │   └── terraform-validate-all.yml
├── README.md
└── other_project_files/





git clone https://github.com/your-username/environments-project.git
cd environments-project
Install AWS CLI: Linux/Mac - environments-project/scripts/setup-aws-cli.sh / Windows - environments-project/scripts/setup-aws-cli.ps1
Configure AWS CLI: 
Ensure your AWS CLI is configured to interact with your AWS account:

bash
Copy code
aws configure
Initialize Terraform:
Initialize Terraform in each environment directory:

bash
Copy code
cd development
terraform init
Usage
Deploying Infrastructure
To deploy the infrastructure for all environments, trigger the terraform-deploy-all.yml workflow in GitHub Actions.

Destroying Infrastructure
To destroy the infrastructure for all environments, trigger the terraform-destroy-all.yml workflow in GitHub Actions.

Rebuilding Environments
To rebuild the infrastructure (including monitoring) for a specific environment:

Development: Trigger the terraform-rebuild-development.yml workflow.
Staging: Trigger the terraform-rebuild-staging.yml workflow.
Production: Trigger the terraform-rebuild-production.yml workflow.
Exposing Grafana Externally
To expose the Grafana dashboard externally, trigger the terraform-expose-grafana-externally.yml workflow. To revert the exposure, use the terraform-revert-grafana-expose.yml workflow.

GitHub Actions Workflows
The project includes several GitHub Actions workflows that automate the deployment, management, and destruction of the infrastructure:

terraform-state-bucket.yml: Creates S3 buckets for storing Terraform state files.
terraform-state-bucket-destroy.yml: Destroys the S3 buckets for Terraform state files.
terraform-runner-deploy.yml: Deploys VPC and EKS clusters, and configures GitHub runners.
terraform-runner-destroy.yml: Destroys VPC and EKS clusters.
terraform-monitoring.yml: Deploys Grafana and Prometheus for monitoring.
terraform-monitoring-destroy.yml: Destroys the Grafana and Prometheus resources.
terraform-deploy-all.yml: Sequentially deploys all infrastructure components.
terraform-destroy-all.yml: Sequentially destroys all infrastructure components.
terraform-expose-grafana-externally.yml: Exposes Grafana externally.
terraform-revert-grafana-expose.yml: Reverts Grafana to internal access.
terraform-rebuild-development.yml: Rebuilds the development environment.
terraform-rebuild-staging.yml: Rebuilds the staging environment.
terraform-rebuild-production.yml: Rebuilds the production environment.
Modules
The project uses Terraform modules to organize and manage the infrastructure:

VPC Module (modules/vpc/main.tf): Manages the Virtual Private Cloud and networking components.
K8s Module (modules/k8s/main.tf): Manages the Kubernetes (EKS) cluster and node groups.
Monitoring Module (modules/monitoring/main.tf): Manages the deployment of Grafana and Prometheus for monitoring.
Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss any changes.