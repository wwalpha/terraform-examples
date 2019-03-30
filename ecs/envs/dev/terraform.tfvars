# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
shared_credentials_file = "C:\\Users\\remoter\\.aws\\credentials"

aws_profile = "default"

configs_path = "../configs"

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
region = "ap-northeast-1"

bucket = "tf-examples"

prefix = "dev-ecs"

# --------------------------------------------------------------------------------
# VPC Configs
# --------------------------------------------------------------------------------
vpc_cidr_block = "10.100.0.0/16"

vpc_azs = ["ap-northeast-1a", "ap-northeast-1c"]

vpc_public_subnets = ["10.100.1.0/26", "10.100.1.128/26"]

# --------------------------------------------------------------------------------
# Container Configs
# --------------------------------------------------------------------------------
container_name = "nginx"

container_image = "nginx:latest"

container_cpu = 256

container_memory = 512

container_port = 80

essential = true

ecs_log_group = "/ecs/dev-fargate"

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

