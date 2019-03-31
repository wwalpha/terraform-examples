# --------------------------------------------------------------------------------
# Terraform Configs
# --------------------------------------------------------------------------------
shared_credentials_file = "C:\\Users\\remoter\\.aws\\credentials"

aws_profile = "default"

configs_path = "./configs"

# --------------------------------------------------------------------------------
# AWS Commons
# --------------------------------------------------------------------------------
region = "ap-northeast-1"

bucket = "tf-examples"

prefix = "ecs"

# --------------------------------------------------------------------------------
# AWS CodeBuild
# --------------------------------------------------------------------------------
project_name = "codebuild"

github_repo = "https://github.com/wwalpha/aws-pipeline-ecs.git"

github_clone_depth = 1

builder_size = "small"

builder_image = "aws/codebuild/docker:18.09.0-1.7.0"

build_timeout = 5

build_spec = ""

artifacts_type = "NO_ARTIFACTS"

# --------------------------------------------------------------------------------
# AWS ECR
# --------------------------------------------------------------------------------
ecr_name = "ecs-express"
