variable "ALB_ARN" {
  default     = ""
  description = "ALB ARN"
}

variable "ALB_PORT" {
  default     = "443"
  description = "ALB Port"
}

variable "DOMAIN" {
  default     = ""
  description = "Website domain name"
}

variable "TARGET_GROUP_ARN" {
  default     = ""
  description = "The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead"
}

variable "ALB_PROTOCOL" {
  default     = "HTTPS"
  description = "ALB Protocol"
}
