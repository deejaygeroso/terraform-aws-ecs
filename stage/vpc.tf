# ---------------------------------------------------------
# VPC Config
# ---------------------------------------------------------
module "main-vpc" {
  source = "../modules/vpc"

  #   AWS_REGION      = var.AWS_REGION
  #   CIDR            = var.CIDR
  #   ENV             = var.ENV
  #   PRIVATE_SUBNETS = var.PRIVATE_SUBNETS
  #   PUBLIC_SUBNETS  = var.PUBLIC_SUBNETS
}
