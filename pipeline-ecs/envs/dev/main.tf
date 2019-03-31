terraform {
  backend "s3" {
    bucket = "tf-examples"
    region = "ap-northeast-1"
    key    = "pipeline-ecs/tfstate"
  }
}

provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.aws_profile}"
  region                  = "${var.region}"
  version                 = "2.3.0"
}

module "dev" {
  source = "../../src"

  configs_path = "${var.configs_path}"
  region       = "${var.region}"
  prefix       = "${var.prefix}"

  project_name       = "${var.project_name}"
  project_tags       = "${var.project_tags}"
  github_repo        = "${var.github_repo}"
  github_clone_depth = "${var.github_clone_depth}"

  builder_size  = "${var.builder_size}"
  builder_image = "${var.builder_image}"
  build_timeout = "${var.build_timeout}"
  build_spec    = "${var.build_spec}"

  build_env_vars = "${var.build_env_vars}"
  artifacts_type = "${var.artifacts_type}"
  ecr_name       = "ecs-${var.ecr_name}"
}
