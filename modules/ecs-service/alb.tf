# ---------------------------------------------------------
# ALB Target Group
# ---------------------------------------------------------
resource "aws_alb_target_group" "ecs-service" {
  name = "${var.APPLICATION_NAME}-${substr(
    md5(
      format(
        "%s%s%s",
        var.APPLICATION_PORT,
        var.DEREGISTRATION_DELAY,
        var.HEALTHCHECK_MATCHER,
      ),
    ),
    0,
    12,
  )}"

  deregistration_delay = var.DEREGISTRATION_DELAY
  port                 = var.APPLICATION_PORT
  protocol             = "HTTP"
  vpc_id               = var.VPC_ID

  health_check {
    interval            = 60
    healthy_threshold   = 3
    matcher             = var.HEALTHCHECK_MATCHER
    path                = "/"
    protocol            = "HTTP"
    unhealthy_threshold = 3
  }
}
