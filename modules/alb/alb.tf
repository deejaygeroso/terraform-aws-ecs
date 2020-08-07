# ---------------------------------------------------------
# ECS ALB Main Definition
# ---------------------------------------------------------
resource "aws_alb" "alb" {
  enable_deletion_protection = false
  internal                   = var.INTERNAL
  name                       = var.ALB_NAME
  security_groups            = [aws_security_group.alb.id]
  subnets                    = split(",", var.VPC_SUBNETS)

}

# ---------------------------------------------------------
# Certificate
# ---------------------------------------------------------
data "aws_acm_certificate" "certificate" {
  domain   = var.DOMAIN
  statuses = ["ISSUED", "PENDING_VALIDATION"]
}

# ---------------------------------------------------------
# ALB Listener (https)
# ---------------------------------------------------------
resource "aws_alb_listener" "alb-https" {
  certificate_arn   = data.aws_acm_certificate.certificate.arn
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    target_group_arn = var.DEFAULT_TARGET_ARN
    type             = "forward"
  }
}

# ---------------------------------------------------------
# ALB Listener (http)
# ---------------------------------------------------------
resource "aws_alb_listener" "alb-http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = var.DEFAULT_TARGET_ARN
    type             = "forward"
  }
}
