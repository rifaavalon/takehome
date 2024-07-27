provider "aws" {
  region = "us-west-2"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.21"
  subnets         = ["subnet-123456", "subnet-654321"]
  vpc_id          = "vpc-123abc"

  node_groups = {
    example = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "m5.large"
    }
  }
}