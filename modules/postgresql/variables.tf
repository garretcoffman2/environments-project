variable "vpc_id" {
  description = "The ID of the VPC where the PostgreSQL instance will be deployed."
}

variable "subnet_ids" {
  description = "The IDs of the subnets to associate with the RDS instance."
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "The list of CIDR blocks allowed to access the PostgreSQL instance."
  type        = list(string)
}

variable "allocated_storage" {
  description = "The allocated storage for the PostgreSQL instance."
  default     = 20
}

variable "engine_version" {
  description = "The version of the PostgreSQL engine."
  default     = "13.4"
}

variable "instance_class" {
  description = "The instance class for the PostgreSQL RDS instance."
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "The name of the database to create."
  default     = "grafanadb"
}

variable "db_username" {
  description = "The username for the PostgreSQL database."
  default     = "grafana"
}

variable "db_password" {
  description = "The password for the PostgreSQL database."
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
}
