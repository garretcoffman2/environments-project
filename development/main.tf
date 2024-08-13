provider "aws" {
  region = "us-west-1"
}

module "vpc" {
  source = "../modules/vpc"

  vpc_cidr           = "10.0.0.0/16"          # CIDR block for the development VPC
  public_subnet_cidrs = ["10.0.1.0/24"]       # Public subnet CIDR block(s)
  private_subnet_cidrs = ["10.0.2.0/24"]      # Private subnet CIDR block(s) (if applicable)
  enable_dns_support  = true                  # Enable DNS support in the VPC
  enable_dns_hostnames = true                 # Enable DNS hostnames in the VPC
  tags = {
    Name        = "development-vpc"
    Environment = "development"
  }
}

module "k8s" {
  source = "../modules/k8s"

  vpc_id         = module.vpc.vpc_id          # Reference the VPC ID from the vpc module
  public_subnet_ids = module.vpc.public_subnet_ids # Reference the public subnets from the vpc module
  private_subnet_ids = module.vpc.private_subnet_ids # Reference the private subnets (if applicable)
  environment    = "development"
}
