
resource "aws_eks_node_group" "public_nodes" {
  provider          = aws.devstage
  cluster_name      = var.cluster_name
  node_group_name   = local.public_node_group_name
  node_role_arn     = aws_iam_role.node_group_role.arn
  subnet_ids        = var.public_subnet_ids
  instance_types    = var.node_instance_types
  capacity_type     = "ON_DEMAND"
  disk_size         = var.node_disk_size
  ami_type          = "AL2_x86_64"

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }

  remote_access {
    ec2_ssh_key = var.ssh_key_name
  }

 
}


resource "aws_eks_node_group" "private_nodes" {
  provider          = aws.devstage
  cluster_name      = var.cluster_name
  node_group_name   = local.private_node_group_name
  node_role_arn     = aws_iam_role.node_group_role.arn
  subnet_ids        = var.private_subnet_ids
  instance_types    = var.node_instance_types
  capacity_type     = "ON_DEMAND"
  disk_size         = var.node_disk_size
  ami_type          = "AL2_x86_64"

  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }


}
locals {
  public_node_group_name  = "${var.project_name}-${var.environment}-public"
  private_node_group_name = "${var.project_name}-${var.environment}-private"

  common_tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_iam_role" "node_group_role" {
  name = "${var.project_name}-${var.environment}-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "registry_readonly_policy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


