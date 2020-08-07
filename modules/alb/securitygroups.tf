resource "aws_security_group" "alb" {
  description = var.ALB_NAME
  name        = var.ALB_NAME
  vpc_id      = var.VPC_ID

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
}

resource "aws_security_group_rule" "cluster-allow-alb" {
  from_port                = 32768
  protocol                 = "tcp"
  to_port                  = 61000
  type                     = "ingress"
  security_group_id        = var.ECS_SG
  source_security_group_id = aws_security_group.alb.id
}
