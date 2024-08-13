# Creates the EKS cluster and configures the VPC and subnet settings.
resource "aws_eks_cluster" "this" {
  name     = "${var.environment}-eks-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = {
    Name = "${var.environment}-eks-cluster"
  }
}

# Creates an IAM role for the EKS cluster to allow it to access other AWS services.
resource "aws_iam_role" "eks_role" {
  name = "${var.environment}-eks-role"

  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json

  tags = {
    Name = "${var.environment}-eks-role"
  }
}

# Additional resources like worker node groups, security groups, and IAM policies could go here.
