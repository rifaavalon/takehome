# Define the TLS private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Define the AWS key pair
resource "aws_key_pair" "my_key" {
  key_name   = "my-key"
  public_key = tls_private_key.my_key.public_key_openssh
}

# Define the EKS module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 17.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.30" # Adjust as needed

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

# Define the Kubernetes provider
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Data source to get EKS cluster authentication details
data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

# Define the aws-auth ConfigMap
resource "kubernetes_config_map" "aws_auth" {
  depends_on = [module.eks]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([{
      rolearn  = aws_iam_role.eks_node_role.arn
      username = "system:node:{{EC2PrivateDNSName}}"
      groups   = ["system:bootstrappers", "system:nodes"]
    }])
  }
}

# Define the ECR repository
resource "aws_ecr_repository" "takehome_repo" {
  name                 = "takehome_repo"  # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"

  tags = {
    Name = "takehome_repo"
  }
}

# Define the ECR lifecycle policy
resource "aws_ecr_lifecycle_policy" "takehome_repo_policy" {
  repository = aws_ecr_repository.takehome_repo.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 30 days"
        selection    = {
          countType  = "sinceLastUsed"
          countUnit  = "days"
          countNumber = 30
        }
        action       = {
          type = "expire"
        }
      }
    ]
  })
}
