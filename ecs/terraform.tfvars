# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
configs_path = "./configs"

# --------------------------------------------------------------------------------
# VPC Configs
# --------------------------------------------------------------------------------
vpc_name           = "Fargate VPC"
vpc_cidr_block     = "10.0.0.0/16"
vpc_public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
# --------------------------------------------------------------------------------
# AWS Security Group
# --------------------------------------------------------------------------------
alb_security_group_name = "ALBSecurityGroup"
ecs_security_group_name = "ECSSecurityGroup"
# --------------------------------------------------------------------------------
# Elastic Container Service
# --------------------------------------------------------------------------------
ecs_cluster_name                  = "ecs-cluster"
ecs_service_name                  = "app-service"
ecs_task_family                   = "ecs-task"
ecs_desired_count                 = 1
ecs_launch_type                   = "FARGATE"
ecs_task_container_name           = "fargate-app"
ecs_task_requires_compatibilities = "FARGATE"
ecs_task_container_image          = "httpd:2.4"

ecs_log_group = "/ecs/first-run-task-definition"

# --------------------------------------------------------------------------------
# Application Load Balancing
# --------------------------------------------------------------------------------
lb_name                     = "fargate-alb"
lb_type                     = "application"
lb_protocol                 = "HTTP"
lb_port                     = 80
lb_target_group_name        = "ECSTargetGroup"
lb_target_group_target_type = "ip"

