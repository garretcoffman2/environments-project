environments-project/
├── modules/
│   ├── grafana/
│   │   ├── main.tf                   # Terraform module to set up Grafana
│   │   ├── variables.tf              # Variables for the Grafana module
│   ├── postgres/
│   │   ├── main.tf                   # Terraform module to create the PostgreSQL RDS instance
│   │   ├── variables.tf              # Variables for the PostgreSQL module
│   ├── k8s/
│   │   ├── main.tf                   # Terraform module to set up Kubernetes clusters
│   │   ├── variables.tf              # Variables for the Kubernetes module
│   └── vpc/
│       ├── main.tf                   # Terraform module to create VPCs and related networking components
│       └── variables.tf              # Variables for the VPC module
├── development/
│   ├── main.tf                       # Terraform configuration for the development environment
│   ├── variables.tf                  # Variables specific to the development environment
│   ├── provider.tf                   # AWS provider and backend configuration for development
├── staging/
│   ├── main.tf                       # Terraform configuration for the staging environment
│   ├── variables.tf                  # Variables specific to the staging environment
│   ├── provider.tf                   # AWS provider and backend configuration for staging
├── production/
│   ├── main.tf                       # Terraform configuration for the production environment
│   ├── variables.tf                  # Variables specific to the production environment
│   ├── provider.tf                   # AWS provider and backend configuration for production
├── prometheus/
│   ├── main.tf                       # Terraform configuration for setting up Prometheus in each environment
│   ├── variables.tf                  # Variables for Prometheus setup
└── .github/
    └── workflows/
        ├── terraform-grafana-deploy.yml      # GitHub Actions workflow to deploy Grafana
        ├── terraform-grafana-destroy.yml     # GitHub Actions workflow to destroy Grafana
        ├── terraform-postgresql-deploy.yml   # GitHub Actions workflow to deploy PostgreSQL
        ├── terraform-postgresql-destroy.yml  # GitHub Actions workflow to destroy PostgreSQL
        ├── terraform-state-bucket.yml        # Workflow to create S3 buckets for storing Terraform state files
        ├── terraform-state-bucket-destroy.yml # Workflow to destroy the S3 buckets for Terraform state files
        ├── terraform-deploy-all.yml          # Workflow to deploy all infrastructure components
        ├── terraform-destroy-all.yml         # Workflow to destroy all infrastructure components
        ├── terraform-expose-grafana-externally.yml # Workflow to expose Grafana externally via a LoadBalancer
        └── terraform-revert-grafana-expose.yml # Workflow to revert Grafana service type to internal ClusterIP
