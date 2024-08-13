# Creates a Virtual Private Cloud (VPC) with the specified CIDR block and enables DNS.
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.environment}-vpc"
  }
}

# Creates public subnets within the VPC, distributed across multiple availability zones.
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.this.id
  cidr_block = element(var.public_subnet_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

# Additional resources like private subnets, route tables, and Internet Gateway (IGW) would go here.
