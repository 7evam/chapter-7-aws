data "aws_iam_policy_document" "assume_role_cluster" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "flixtube_eks_role" {
  name               = "flixtube_eks_cluster_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_cluster.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.flixtube_eks_role.name
}
