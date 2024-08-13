variable "vpc_id" {
  description = "The ID of the VPC where Grafana will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs where Grafana will be deployed"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "A list of private subnet IDs (if used)"
  type        = list(string)
  default     = []
}

variable "db_host" {
  description = "The address of the PostgreSQL database"
  type        = string
}

variable "db_port" {
  description = "The port of the PostgreSQL database"
  type        = number
  default     = 5432
}

variable "db_name" {
  description = "The name of the Grafana database"
  type        = string
  default     = "grafanadb"
}

variable "db_user" {
  description = "The username for the PostgreSQL database"
  type        = string
  default     = "grafana"
}

variable "db_password" {
  description = "The password for the PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "The type of instance to use for the Grafana EC2 instance"
  type        = string
  default     = "t3.medium"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
