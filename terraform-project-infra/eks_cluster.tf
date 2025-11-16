resource "aws_eks_cluster" "godwin_cluster" {
  name     = "godwin-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnets[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy,
    aws_iam_role_policy_attachment.eks_vpc_resource_controller
  ]

  tags = {
    Name  = "godwin-eks-cluster"
    Owner = "Godwin"
  }
}

resource "aws_eks_node_group" "godwin_node_group" {
  cluster_name    = aws_eks_cluster.godwin_cluster.name
  node_group_name = "godwin-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.eks_subnets[*].id

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 5
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_registry_policy
  ]

  tags = {
    Name  = "godwin-node-group"
    Owner = "Godwin"
  }
}
