module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.21" # Or any version you prefer

  vpc_id = aws_vpc.my_vpc.id # Move the "vpc_id" attribute here

    
}
