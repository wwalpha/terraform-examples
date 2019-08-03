# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
configs_path = "./configs"

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
bucket = "tf-examples"

prefix = "dev-ecs"

# --------------------------------------------------------------------------------
# VPC Configs
# --------------------------------------------------------------------------------
vpc_cidr_block = "10.100.0.0/16"

vpc_azs = ["ap-northeast-1a", "ap-northeast-1c"]

vpc_public_subnets = ["10.100.1.0/26", "10.100.1.128/26"]

# --------------------------------------------------------------------------------
# Elastic Container Service
# --------------------------------------------------------------------------------
ecs_cluster_name = "ecs-cluster"
ecs_service_name = "sample-app-service"
# --------------------------------------------------------------------------------
# Container Configs
# --------------------------------------------------------------------------------
container_name = "sample-app"

container_image = "httpd:2.4"

container_cpu = 256

container_memory = 512

container_port = 80


ecs_log_group = "/ecs/first-run-task-definition"

# container_memory_reservation = "${var.container_memory_reservation}"


# entrypoint                   = "${var.entrypoint}"
# command                      = "${var.command}"


# Fargate only awslog
# log_driver                   = "${local.log_driver}"
# log_options = "${local.log_options}"


# port_mappings = "${local.port_mappings}"


# healthcheck = "${var.healthcheck}"


# dns_servers = "${var.dns_servers}"


# environment = "${var.environment}"


# secrets = "${var.secrets}"


# working_directory = "${var.working_directory}"


# readonly_root_filesystem = "${var.readonly_root_filesystem}"


# mount_points = "${var.mount_points}"

