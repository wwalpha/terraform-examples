terraform import aws_ecs_cluster.fargate ecs-cluster

terraform import aws_ecs_task_definition.fargate arn:aws:ecs:ap-northeast-1:818282415957:task-definition/first-run-task-definition:3
terraform import aws_iam_role.ecs_task_exec_role ecsTaskExecutionRole

terraform import aws_ecs_service.fargate ecs-cluster/sample-app-service

terraform import aws_vpc.fargate vpc-003b6354dfd1b1abe

terraform import aws_subnet.public1 subnet-05da645c476f62e18

terraform import aws_subnet.public2 subnet-0f5f237adf70cca29

terraform import aws_security_group.ecs_sg sg-0a316733269c452e9
terraform import aws_security_group.alb_sg sg-0654d49b5749b2767

terraform import aws_lb.bar arn:aws:elasticloadbalancing:us-west-2:123456789012:loadbalancer/app/my-load-balancer/50dc6c495c0c9188

terraform import aws_lb_target_group.app_front_end arn:aws:elasticloadbalancing:us-west-2:187416307283:targetgroup/app-front-end/20cfe21448b66314
