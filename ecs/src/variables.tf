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

variable "bucket" {}

variable "prefix" {}

# --------------------------------------------------------------------------------
# VPC Configs
# --------------------------------------------------------------------------------
variable "vpc_cidr_block" {}

variable "vpc_azs" {
  type = "list"
}

variable "vpc_public_subnets" {
  type = "list"
}

# --------------------------------------------------------------------------------
# Container Configs
# --------------------------------------------------------------------------------
variable "container_cpu" {
  default = 256 # 0.25CPU
}

variable "container_memory" {
  default = 512 # 0.5G Memory
}

variable "container_port" {
  default = 80
}

variable "ecs_log_group" {}

variable "ecs_log_driver" {
  default = "awslogs"
}
