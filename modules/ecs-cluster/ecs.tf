# ---------------------------------------------------------
# ECS Cluster
# ---------------------------------------------------------
resource "aws_ecs_cluster" "cluster" {
  name = var.CLUSTER_NAME
}

# ---------------------------------------------------------
# Auto-scaling Group
# ---------------------------------------------------------
resource "aws_autoscaling_group" "cluster" {
  desired_capacity     = var.ECS_DESIRED_CAPACITY
  launch_configuration = aws_launch_configuration.cluster.name
  max_size             = var.ECS_MAXSIZE
  min_size             = var.ECS_MINSIZE
  name                 = "ecs-${var.CLUSTER_NAME}-autoscaling"
  termination_policies = split(",", var.ECS_TERMINATION_POLICIES)
  vpc_zone_identifier  = split(",", var.VPC_SUBNETS)

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.CLUSTER_NAME}-ecs"
  }
}

# ---------------------------------------------------------
# Launch Config
# ---------------------------------------------------------
resource "aws_launch_configuration" "cluster" {
  name_prefix          = "ecs-${var.CLUSTER_NAME}-launchconfig"
  iam_instance_profile = aws_iam_instance_profile.cluster-ec2-role.id
  image_id             = data.aws_ami.ecs.id
  instance_type        = var.INSTANCE_TYPE
  key_name             = var.SSH_KEY_NAME
  security_groups      = [aws_security_group.cluster.id]
  user_data            = data.template_file.ecs_init.rendered

  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------
# ECS AMI
# ---------------------------------------------------------
data "aws_ami" "ecs" {
  most_recent = true
  owners      = ["591542846629"] # AWS

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# ---------------------------------------------------------
# ECS Template File
# ---------------------------------------------------------
data "template_file" "ecs_init" {
  template = file("${path.module}/templates/ecs_init.tpl")

  vars = {
    CLUSTER_NAME = var.CLUSTER_NAME
  }
}
