# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
variable "configs_path" {}

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
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
# Elastic Container Service
# --------------------------------------------------------------------------------
variable "ecs_cluster_name" {}
variable "ecs_service_name" {}

# --------------------------------------------------------------------------------
# Container Configs
# --------------------------------------------------------------------------------
variable "container_name" {}

variable "container_image" {}

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
