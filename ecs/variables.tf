variable "aws_profile" {
  type    = "string"
  default = "default"
}

variable "region" {
  type    = "string"
  default = "ap-northeast-1"
}

variable "project" {
  type    = "string"
  default = "ecs"
}

variable "env" {
  type    = "string"
  default = "dev"
}

variable "shared_credentials_file" {
  type    = "string"
  default = "C:\\Users\\remoter\\.aws\\credentials"
}

variable "container_cpu" {
  default = 256 # 0.25CPU
}

variable "container_memory" {
  default = 512 # 0.5G Memory
}

variable "container_port" {
  default = 80
}

variable "vpc_cidr_block" {
  default = "10.110.0.0/16"
}

variable "public1_cidr_block" {
  default = "10.110.1.0/26"
}

variable "public2_cidr_block" {
  default = "10.110.1.128/26"
}
