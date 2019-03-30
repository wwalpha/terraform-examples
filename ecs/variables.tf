# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------

variable "shared_credentials_file" {
  type = "string"
}

variable "aws_profile" {
  type = "string"
}

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
variable "region" {
  type = "string"
}

variable "prefix" {
  type = "string"
}

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
