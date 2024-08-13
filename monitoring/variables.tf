variable "key_name" {
  description = "Key pair name for SSH access"
  default     = "your-key-pair"  # Replace with your actual key pair name
}

variable "db_password" {
  description = "The password for the Grafana PostgreSQL database"
  type        = string
  sensitive   = true
}
