module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 17.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.21" # Or any version you prefer

  subnets         = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  vpc_id           = aws_vpc.my_vpc.id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
      key_name       = "my-key" # Replace with your key pair name
    }
  }

  node_group_defaults = {
    iam_role = aws_iam_role.eks_node_role.arn
  }
}
