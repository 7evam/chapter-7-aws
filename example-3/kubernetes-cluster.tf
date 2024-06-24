#
# Creates a managed Kubernetes cluster on AWS
#

# Get the default vpc
data "aws_vpc" "default_vpc" {
  default = true
}

# Get subnets associated with the default VPC
data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default_vpc.id]
  }
}

resource "aws_eks_cluster" "flixtube" {
  name    = var.app_name
  version = var.kubernetes_version
  tags = {
    Stage = "Test"
  }
  vpc_config {
    subnet_ids = data.aws_subnets.subnets.ids
  }
  role_arn   = aws_iam_role.flixtube_eks_role.arn
  depends_on = [aws_iam_role_policy_attachment.eks_cluster_policy_attachment]
}

output "endpoint" {
  value = aws_eks_cluster.flixtube.endpoint
}
