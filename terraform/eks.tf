provider "aws" {
  region = "us-west-2"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "takehome"
  cluster_version = "1.21"
  vpc_id          = "vpc-123abc"

}