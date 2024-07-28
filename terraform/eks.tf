resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = tls_private_key.my_key.public_key_openssh
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 17.0"

  cluster_name    = "takehome"
  cluster_version = "1.30" # Or any version you prefer

  subnets         = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
  vpc_id           = aws_vpc.my_vpc.id

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
      key_name       = aws_key_pair.my_key.key_name
    }
  }

  node_groups_defaults = {
    iam_role = aws_iam_role.eks_node_role.arn
  }
}
