# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
variable "configs_path" {}

# --------------------------------------------------------------------------------
# VPC Configs
# --------------------------------------------------------------------------------
variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "vpc_public_subnets" {
  type    = "list"
  default = []
}
# --------------------------------------------------------------------------------
# AWS Security Group
# --------------------------------------------------------------------------------
variable "alb_security_group_name" {}
variable "ecs_security_group_name" {}
# --------------------------------------------------------------------------------
# Elastic Container Service
# --------------------------------------------------------------------------------
variable "ecs_cluster_name" {}
variable "ecs_service_name" {}
variable "ecs_desired_count" {}
variable "ecs_launch_type" {}
variable "ecs_task_family" {}
variable "ecs_task_container_name" {}
variable "ecs_task_requires_compatibilities" {}
variable "ecs_task_container_image" {}
variable "ecs_task_container_cpu" {
  default = 256 # 0.25CPU
}
variable "ecs_task_container_memory" {
  default = 512 # 0.5G Memory
}
variable "ecs_task_container_port" {
  default = 80
}
variable "ecs_log_group" {}
variable "ecs_log_driver" {
  default = "awslogs"
}
# --------------------------------------------------------------------------------
# Application Load Balancing
# --------------------------------------------------------------------------------
variable "lb_name" {}
variable "lb_type" {}
variable "lb_protocol" {}
variable "lb_port" {}
variable "lb_target_group_name" {}
variable "lb_target_group_target_type" {}
