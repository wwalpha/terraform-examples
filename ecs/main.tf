terraform {
  backend "s3" {
    bucket = "tf-examples"
    region = "ap-northeast-1"
    key    = "ecs-fargate/tfstate"
  }
}

provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  profile                 = "${var.aws_profile}"
  region                  = "${var.region}"
  version                 = "2.3.0"
}
