module "vpc" {
  source = "./vpc"
  # source = "github.com/wwalpha/terraform-module-registry/aws/vpc"

  vpc_name       = "${var.vpc_name}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  public_subnets = "${var.vpc_public_subnets}"
}
