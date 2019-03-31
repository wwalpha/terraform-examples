# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
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
  type = "map"
}

variable "github_repo" {}
variable "github_clone_depth" {}
variable "builder_size" {}
variable "builder_image" {}
variable "build_timeout" {}
variable "build_spec" {}

variable "build_env_vars" {
  type = "list"
}

variable "artifacts_type" {}

# --------------------------------------------------------------------------------
# AWS ECR
# --------------------------------------------------------------------------------
variable "ecr_name" {}
