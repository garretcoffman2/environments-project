variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "environment" {
  description = "The environment name (e.g., development, staging, production)"
  default     = "development"
}

# This variable is now set to false to prevent Grafana from being deployed here
variable "deploy_grafana" {
  description = "Deploy Grafana instance in this environment"
  default     = false
}
