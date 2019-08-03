# -----------------------------------------------
# AWS Provider
# -----------------------------------------------
provider "aws" {}

# -----------------------------------------------
# Terraform Settings
# -----------------------------------------------
terraform {
  backend "s3" {
    bucket = "terraform-workspaces"
    region = "ap-northeast-1"
    key    = "ecs-fargate/example.tfstate"
  }

  required_version = ">= 0.12"
}
