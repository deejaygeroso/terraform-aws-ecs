# ---------------------------------------------------------
# General Variables (Dynamically used everywhere)
# ---------------------------------------------------------
variable "APPLICATION_NAME" {
  default     = "myproject-service"
  description = "(Required) The name of the application."
}
variable "APPLICATION_VERSION" {
  default     = ""
  description = "Application Version"
}

# ---------------------------------------------------------
# Scheduling
# ---------------------------------------------------------
variable "AWS_REGION" {
  default     = "us-east-1"
  description = "A seperate geographic area that consist of multiple isolated availability zones"
}
variable "CLUSTER_ARN" {
}
variable "EVENTS_ROLE_ARN" {
}
variable "SCHEDULE" {
}

# ---------------------------------------------------------
# Task Definition Template
# ---------------------------------------------------------
variable "CPU_RESERVATION" {
}
variable "LOG_GROUP" {
}
variable "MEMORY_RESERVATION" {
}
variable "TASK_DEF_TEMPLATE" {
}

# ---------------------------------------------------------
# Task Definition
# ---------------------------------------------------------
variable "TASK_ROLE_ARN" {
  default = ""
}

# ---------------------------------------------------------
# ECR
# ---------------------------------------------------------
variable "ECR_PREFIX" {
  default = ""
}
