provider "aws" {
  region = "us-west-1"
}

# Create a VPC for the monitoring environment
resource "aws_vpc" "monitoring_vpc" {
  cidr_block = "10.3.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "monitoring-vpc"
  }
}

# Create a public subnet in the monitoring VPC
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.monitoring_vpc.id
  cidr_block        = "10.3.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-1a"

  tags = {
    Name = "monitoring-public-subnet"
  }
}

# Create an Internet Gateway for the monitoring VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.monitoring_vpc.id

  tags = {
    Name = "monitoring-igw"
  }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.monitoring_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "monitoring-public-route-table"
  }
}

# Associate the route table with the public subnet
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Security group to allow traffic from the Kubernetes VPCs
resource "aws_security_group" "grafana_sg" {
  vpc_id = aws_vpc.monitoring_vpc.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16", "10.1.0.0/16", "10.2.0.0/16"]  # Replace with the CIDR blocks of your Kubernetes VPCs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "grafana-sg"
  }
}

# Security group for the RDS instance
resource "aws_security_group" "grafana_db_sg" {
  vpc_id = aws_vpc.monitoring_vpc.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.3.0.0/16"]  # Limit access to the VPC for monitoring
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "grafana-db-sg"
  }
}

# Create a DB subnet group for the RDS instance
resource "aws_db_subnet_group" "grafana_db_subnet" {
  name       = "grafana-db-subnet"
  subnet_ids = [aws_subnet.public_subnet.id]

  tags = {
    Name = "grafana-db-subnet"
  }
}

# Create a PostgreSQL RDS instance for Grafana
resource "aws_db_instance" "grafana_db" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  name                 = "grafanadb"
  username             = "grafana"
  password             = var.db_password
  parameter_group_name = "default.postgres13"
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.grafana_db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.grafana_db_subnet.name

  tags = {
    Name = "grafana-db"
  }
}

# EC2 instance to host Grafana within the monitoring VPC
resource "aws_instance" "grafana" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.medium"
  key_name      = var.key_name
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.grafana_sg.name]

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y software-properties-common
              apt-add-repository universe
              apt-get update -y
              
              # Install Grafana and PostgreSQL client
              apt-get install -y grafana postgresql-client

              # Configure Grafana to use PostgreSQL
              cat <<EOL >> /etc/grafana/grafana.ini
              [database]
              type = postgres
              host = ${aws_db_instance.grafana_db.address}:5432
              name = grafanadb
              user = grafana
              password = ${var.db_password}
              ssl_mode = disable
              EOL

              # Start Grafana service
              systemctl start grafana-server
              systemctl enable grafana-server
              EOF

  tags = {
    Name = "grafana-monitoring"
  }
}

# Output the public IP of the EC2 instance
output "grafana_public_ip" {
  value = aws_instance.grafana.public_ip
}
