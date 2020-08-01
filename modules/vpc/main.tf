# ---------------------------------------------------------
# VPC Config
# ---------------------------------------------------------
module "vpc" {
  azs                = ["${var.AWS_REGION}a", "${var.AWS_REGION}b", "${var.AWS_REGION}c"]
  cidr               = var.CIDR
  enable_nat_gateway = false
  enable_vpn_gateway = false
  name               = "vpc-${var.ENV}"
  private_subnets    = var.PRIVATE_SUBNETS
  public_subnets     = var.PUBLIC_SUBNETS
  source             = "terraform-aws-modules/vpc/aws"
  tags = {
    Terraform   = "true"
    Environment = var.ENV
  }
}
