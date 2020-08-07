# ---------------------------------------------------------
# General Variables (Dynamically used everywhere)
# ---------------------------------------------------------
variable "APPLICATION_NAME" {
  default     = "myproject-service"
  description = "(Required) The name of the application."
}
variable "APPLICATION_PORT" {
  default     = ""
  description = "(Required) Port used by the application"
}
variable "AWS_REGION" {
  default     = "us-east-1"
  description = "A seperate geographic area that consist of multiple isolated availability zones"
}
variable "APPLICATION_VERSION" {
  default     = ""
  description = "Application Version"
}

variable "CPU_RESERVATION" {
}
variable "LOG_GROUP" {
}
variable "MEMORY_RESERVATION" {
}
variable "TASK_ROLE_ARN" {
  default = ""
}
variable "ALB_ARN" {
}

# ---------------------------------------------------------
# ALB Target Group
# ---------------------------------------------------------
variable "DEREGISTRATION_DELAY" {
  default     = 30
  description = ""
}
variable "HEALTHCHECK_MATCHER" {
  default = "200"
}
variable "VPC_ID" {
  default     = ""
  description = "VPC ID"
}

# ---------------------------------------------------------
# ECS Service
# ---------------------------------------------------------
variable "CLUSTER_ARN" {
  default     = ""
  description = "(Optional) ARN of an ECS cluster"
}
variable "DEPLOYMENT_MAXIMUM_PERCENT" {
  default     = 200
  description = "(Optional) The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Not valid when using the DAEMON scheduling strategy"
}
variable "DEPLOYMENT_MINIMUM_HEALTHY_PERCENT" {
  default     = 100
  description = "(Optional) The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment"
}
variable "DESIRED_COUNT" {
  default     = ""
  description = "(Optional) The number of instances of the task definition to place and keep running. Defaults to 0. Do not specify if using the DAEMON scheduling strategy."
}
variable "SERVICE_ROLE_ARN" {
  default     = ""
  description = "ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf."
}
