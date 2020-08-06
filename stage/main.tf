# ---------------------------------------------------------
# VPC - Virtual Private Cloud
# Just rename mypproject to your project name
# ---------------------------------------------------------
module "myproject-vpc" {
  source = "../modules/vpc"

  AWS_REGION      = var.AWS_REGION
  CIDR            = var.CIDR
  ENV             = var.ENV
  PRIVATE_SUBNETS = var.PRIVATE_SUBNETS
  PUBLIC_SUBNETS  = var.PUBLIC_SUBNETS
}

# ---------------------------------------------------------
# Caller Identity
# ???????????????
# ---------------------------------------------------------
data "aws_caller_identity" "current" {
}

# ---------------------------------------------------------
# ECS Cluster
# ---------------------------------------------------------
module "myproject-ecs" {
  source         = "../modules/ecs-cluster"
  VPC_ID         = module.myproject-vpc.vpc_id
  CLUSTER_NAME   = "myproject-ecs"
  INSTANCE_TYPE  = var.INSTANCE_TYPE
  SSH_KEY_NAME   = aws_key_pair.mykeypair.key_name
  VPC_SUBNETS    = join(",", module.myproject-vpc.public_subnets)
  ENABLE_SSH     = true
  SSH_SG         = aws_security_group.allow-ssh.id
  LOG_GROUP      = "myproject-log-group"
  AWS_ACCOUNT_ID = data.aws_caller_identity.current.account_id
  AWS_REGION     = var.AWS_REGION
}

# ---------------------------------------------------------
# Service
# ---------------------------------------------------------
module "myproject-service" {
  source              = "../modules/ecs-service"
  VPC_ID              = module.myproject-vpc.vpc_id
  APPLICATION_NAME    = "myproject-service"
  APPLICATION_PORT    = "80"
  APPLICATION_VERSION = "latest"
  CLUSTER_ARN         = module.myproject-ecs.cluster_arn
  SERVICE_ROLE_ARN    = module.myproject-ecs.service_role_arn
  AWS_REGION          = var.AWS_REGION
  HEALTHCHECK_MATCHER = "200"
  CPU_RESERVATION     = "256"
  MEMORY_RESERVATION  = "128"
  LOG_GROUP           = "myproject-log-group"
  DESIRED_COUNT       = 2
  ALB_ARN             = module.myproject-alb.alb_arn
}

# ---------------------------------------------------------
# ALB - Application Load Balancer
# ---------------------------------------------------------
module "myproject-alb" {
  source             = "../modules/alb"
  VPC_ID             = module.myproject-vpc.vpc_id
  ALB_NAME           = "myproject-alb"
  VPC_SUBNETS        = join(",", module.myproject-vpc.public_subnets)
  DEFAULT_TARGET_ARN = module.myproject-service.target_group_arn
  DOMAIN             = "*.deejaygeroso.com"
  INTERNAL           = false
  ECS_SG             = module.myproject-ecs.cluster_sg
}

# ---------------------------------------------------------
# Application Load Balancer Rule
# ---------------------------------------------------------
module "myproject-alb-rule" {
  source           = "../modules/alb-rule"
  LISTENER_ARN     = module.myproject-alb.http_listener_arn
  PRIORITY         = 100
  TARGET_GROUP_ARN = module.myproject-service.target_group_arn
  CONDITION_FIELD  = "host-header"
  CONDITION_VALUES = ["subdomain.ecs.newtech.academy"]
}

# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------
resource "aws_security_group" "allow-ssh" {
  vpc_id      = module.myproject-vpc.vpc_id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  tags = {
    Name = "allow-ssh"
  }
}

# ---------------------------------------------------------
# RSA Key Pair
# ---------------------------------------------------------
resource "aws_key_pair" "mykeypair" {
  key_name   = var.RSA_KEY_FILENAME
  public_key = file("${var.RSA_KEY_FILENAME}.pub")
}
