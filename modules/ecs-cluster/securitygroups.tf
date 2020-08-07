resource "aws_security_group_rule" "cluster-allow-ssh" {
  count                    = var.ENABLE_SSH ? 1 : 0
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.cluster.id
  source_security_group_id = var.SSH_SG
  to_port                  = 22
  type                     = "ingress"
}

resource "aws_security_group_rule" "cluster-egress" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster.id
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group" "cluster" {
  description = var.CLUSTER_NAME
  name        = var.CLUSTER_NAME
  vpc_id      = var.VPC_ID
}
