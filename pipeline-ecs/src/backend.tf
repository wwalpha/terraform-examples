terraform {
  backend "s3" {
    bucket = "tf-examples"
    region = "ap-northeast-1"
    key    = "pipeline-ecs/tfstate"
  }
}
