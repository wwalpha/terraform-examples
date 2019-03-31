# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
variable "shared_credentials_file" {}

variable "aws_profile" {}

variable "configs_path" {}

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
variable "region" {}

variable "prefix" {}

# --------------------------------------------------------------------------------
# AWS CodeBuild
# --------------------------------------------------------------------------------
variable "project_name" {}

variable "project_tags" {
  type    = "map"
  default = {}
}

variable "github_repo" {}
variable "github_clone_depth" {}
variable "builder_size" {}
variable "builder_image" {}
variable "build_timeout" {}
variable "build_spec" {}

variable "build_env_vars" {
  type = "list"

  default = [
    {
      name  = "IMAGE_REPO_NAME"
      value = "ecs-express"
    },
    {
      name  = "IMAGE_TAG"
      value = "1.0"
    },
    {
      name  = "ECR_REPOSITORY_NAME"
      value = "ecs-ecr"
    },
  ]
}

variable "artifacts_type" {}

# --------------------------------------------------------------------------------
# AWS ECR
# --------------------------------------------------------------------------------
variable "ecr_name" {}
