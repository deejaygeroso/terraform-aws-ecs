# ---------------------------------------------------------
# Application Load Balancer Rule
# ---------------------------------------------------------
module "myproject-alb-rule" {
  source = "../modules/alb-rule"

  CONDITION_FIELD  = "host-header"
  CONDITION_VALUES = ["subdomain.ecs.newtech.academy"]
  LISTENER_ARN     = module.myproject-alb.http_listener_arn
  PRIORITY         = 100
  TARGET_GROUP_ARN = module.myproject-service.target_group_arn
}

# ---------------------------------------------------------
# ALB - Application Load Balancer
# ---------------------------------------------------------
module "myproject-alb" {
  source = "../modules/alb"

  ALB_NAME           = "myproject-alb"
  DEFAULT_TARGET_ARN = module.myproject-service.target_group_arn
  DOMAIN             = "*.deejaygeroso.com"
  ECS_SG             = module.myproject-ecs.cluster_sg
  INTERNAL           = false
  VPC_ID             = module.myproject-vpc.vpc_id
  VPC_SUBNETS        = join(",", module.myproject-vpc.public_subnets)
}

# ---------------------------------------------------------
# Service
# ---------------------------------------------------------
module "myproject-service" {
  source = "../modules/ecs-service"

  ALB_ARN             = module.myproject-alb.alb_arn
  APPLICATION_NAME    = "myproject-service"
  APPLICATION_PORT    = "80"
  APPLICATION_VERSION = "latest"
  AWS_REGION          = var.AWS_REGION
  CLUSTER_ARN         = module.myproject-ecs.cluster_arn
  CPU_RESERVATION     = "256"
  DESIRED_COUNT       = 2
  HEALTHCHECK_MATCHER = "200"
  LOG_GROUP           = "myproject-log-group"
  MEMORY_RESERVATION  = "128"
  SERVICE_ROLE_ARN    = module.myproject-ecs.service_role_arn
  VPC_ID              = module.myproject-vpc.vpc_id
}

# ---------------------------------------------------------
# ECS Cluster
# ---------------------------------------------------------
module "myproject-ecs" {
  source = "../modules/ecs-cluster"

  AWS_ACCOUNT_ID = data.aws_caller_identity.current.account_id
  AWS_REGION     = var.AWS_REGION
  CLUSTER_NAME   = "myproject-ecs"
  ENABLE_SSH     = true
  INSTANCE_TYPE  = var.INSTANCE_TYPE
  LOG_GROUP      = "myproject-log-group"
  SSH_KEY_NAME   = aws_key_pair.mykeypair.key_name
  SSH_SG         = aws_security_group.allow-ssh.id
  VPC_ID         = module.myproject-vpc.vpc_id
  VPC_SUBNETS    = join(",", module.myproject-vpc.public_subnets)
}

# ---------------------------------------------------------
# Caller Identity
# ---------------------------------------------------------
data "aws_caller_identity" "current" {
}

# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------
resource "aws_security_group" "allow-ssh" {
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"
  vpc_id      = module.myproject-vpc.vpc_id

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

# ---------------------------------------------------------
# VPC - Virtual Private Cloud
# Just rename myproject with your project name
# ---------------------------------------------------------
module "myproject-vpc" {
  source = "../modules/vpc"

  AWS_REGION      = var.AWS_REGION
  CIDR            = var.CIDR
  ENV             = var.ENV
  PRIVATE_SUBNETS = var.PRIVATE_SUBNETS
  PUBLIC_SUBNETS  = var.PUBLIC_SUBNETS
}
