# ---------------------------------------------------------
# ALB
# ---------------------------------------------------------
variable "ALB_NAME" {
  default     = "myproject-alb"
  description = "ALB name"
}
variable "INTERNAL" {
  default     = false
  description = ""
}
variable "VPC_SUBNETS" {
  default     = ""
  description = "List of Subnets ID"
}

# ---------------------------------------------------------
# ALB Listener
# ---------------------------------------------------------
variable "DEFAULT_TARGET_ARN" {
  default     = ""
  description = "The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead"
}

# ---------------------------------------------------------
# Certificate
# ---------------------------------------------------------
variable "DOMAIN" {
  default     = ""
  description = "Website domain name"
}

# ---------------------------------------------------------
# Security Groups
# ---------------------------------------------------------
variable "ECS_SG" {
  default     = ""
  description = "ECS security group ID"
}
variable "VPC_ID" {
  default     = ""
  description = "VPC ID"
}
