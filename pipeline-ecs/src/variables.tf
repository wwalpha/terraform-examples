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
variable "codebuild_name" {}

variable "codebuild_tags" {
  default = {}
}

variable "build_timeout" {}

variable "build_spec" {}

variable "artifacts_type" {}

variable "builder_size" {
  description = "small or medium or large"
  default     = "small"
}

variable "builder_image" {}

variable "github_count" {}

variable "github_repo" {}

variable "github_clone_depth" {}
