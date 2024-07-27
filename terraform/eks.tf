module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 20.0"

  cluster_name    = "my-cluster"
  cluster_version = "1.21" # Or any version you prefer
  vpc_id          = aws_vpc.my_vpc.id

  fargate_profiles = {
    example = {
      name               = "example"
      pod_execution_role_arn = aws_iam_role.fargate_pod_execution_role.arn
      subnet_ids         = aws_vpc.my_vpc.private_subnet_ids
      selector           = [
        {
          namespace = "kube-system"
          labels    = {
            "k8s-app" = "kube-dns"
          }
        },
        {
          namespace = "default"
        },
      ]
    }
  }
}