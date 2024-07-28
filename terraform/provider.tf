terraform {
  backend "s3" {
    bucket         = "takehome-backend"   # Replace with your S3 bucket name
    key            = "terraform/state"              # Path within the S3 bucket
    region         = "us-west-2"                     # Replace with your region
    dynamodb_table = "terraform-locks"               # Replace with your DynamoDB table name
    encrypt        = true                           # Enable server-side encryption (optional)
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2" # Change to your desired AWS region
}

# Other resources like VPC, EKS cluster, IAM roles, etc.
