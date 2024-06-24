#
# Creates a node group for a Kubernetes cluster on AWS
#

resource "aws_eks_node_group" "flixtube" {
  cluster_name    = var.app_name
  node_group_name = "flixtube"
  node_role_arn   = aws_iam_role.flixtube_node_role.arn
  #   the subnets for the default vpc were retreived in kubernetes-cluster.tf
  subnet_ids     = data.aws_subnets.subnets.ids
  instance_types = ["t3.small"]
  tags = {
    Stage = "Test"
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_eks_cluster.flixtube,
    aws_iam_role_policy_attachment.ecr_readonly_policy_attachment,
    aws_iam_role_policy_attachment.eks_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_worker_node_policy_attachment
  ]
}
