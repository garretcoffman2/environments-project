provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr           = "10.3.0.0/16"          # CIDR block for the Grafana VPC
  public_subnet_cidrs = ["10.3.1.0/24"]       # Public subnet CIDR block(s)
  private_subnet_cidrs = ["10.3.2.0/24"]      # Private subnet CIDR block(s) (if applicable)
  enable_dns_support  = true                  # Enable DNS support in the VPC
  enable_dns_hostnames = true                 # Enable DNS hostnames in the VPC
  tags = {
    Name        = "grafana-vpc"
    Environment = "grafana"
  }
}

module "postgresql" {
  source = "../modules/postgres"

  vpc_id             = module.vpc.vpc_id          # Reference the VPC ID from the vpc module
  subnet_ids         = module.vpc.public_subnet_ids # Reference the subnets from the vpc module
  allowed_cidr_blocks = [module.vpc.vpc_cidr]  # Allow access only from within the VPC
  db_password        = var.db_password

  tags = {
    Name        = "grafana-db"
    Environment = "grafana"
  }
}

module "grafana" {
  source = "../modules/grafana"

  vpc_id         = module.vpc.vpc_id          # Reference the VPC ID from the vpc module
  public_subnet_ids = module.vpc.public_subnet_ids # Reference the public subnets from the vpc module
  private_subnet_ids = module.vpc.private_subnet_ids # Reference the private subnets (if applicable)
  db_host        = module.postgresql.db_address
  db_password    = var.db_password

  tags = {
    Name        = "grafana-server"
    Environment = "grafana"
  }
}

output "grafana_url" {
  description = "The URL to access the Grafana instance"
  value       = "http://${module.grafana.public_dns}:3000"
}
