terraform import aws_ecs_cluster.this ecs-cluster

terraform import aws_ecs_task_definition.this arn:aws:ecs:ap-northeast-1:818282415957:task-definition/first-run-task-definition:4
terraform import aws_iam_role.ecs_task_exec_role ecsTaskExecutionRole

terraform import aws_ecs_service.fargate ecs-cluster/sample-app-service

terraform import aws_vpc.this vpc-024e6e2987060fb33
terraform import aws_network_interface.fargate eni-e5aa89a3
terraform import aws_internet_gateway.fargate igw-06ed49a6a7ad6b29f
terraform import aws_route_table.fargate rtb-4e616f6d69

terraform import aws_subnet.public1 subnet-0632af0a5bb233c23
terraform import aws_subnet.public2 subnet-0a3aaab1a05537050

terraform import aws_security_group.alb_sg sg-0200694e763539e17
terraform import aws_security_group.ecs_sg sg-057a63e66db0641fd

terraform import aws_lb.alb arn:aws:elasticloadbalancing:ap-northeast-1:818282415957:loadbalancer/app/EC2Co-EcsEl-I63KO0M4L0AN/9c3c28f1a29dfc13
terraform import aws_lb_target_group.alb_tg arn:aws:elasticloadbalancing:ap-northeast-1:818282415957:targetgroup/EC2Co-Defau-UQVRHVJHNVL2/86dd97726262652b
