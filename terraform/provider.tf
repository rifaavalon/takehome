terraform {
  required_version = ">= 0.14"
  experiments = [module_variable_optional_attrs]
}

provider "aws" {
  region = "us-west-2" # Change to your desired AWS region
}

# Other resources like VPC, EKS cluster, IAM roles, etc.
