# ---------------------------------------------------------
# General Variables (Dynamically used everywhere)
# ---------------------------------------------------------
variable "CLUSTER_NAME" {
  default     = "myproject"
  description = "Cluster name of your project"
}

# ---------------------------------------------------------
# Launch Config
# ---------------------------------------------------------
variable "INSTANCE_TYPE" {
  default     = "t2.micro"
  description = "EC2 instance type"
}
variable "SSH_KEY_NAME" {
  default     = ""
  description = "SSH key name of your instance"
}

# ---------------------------------------------------------
# Auto-scaling Group
# ---------------------------------------------------------
variable "ECS_DESIRED_CAPACITY" {
  default     = 1
  description = "The number of ec2 instances that should be running in the group"
}
variable "ECS_MAXSIZE" {
  default     = 1
  description = "The maximum size of the auto scale group"
}
variable "ECS_MINSIZE" {
  default     = 1
  description = "The minimum size of the auto scale group"
}
variable "ECS_TERMINATION_POLICIES" {
  default     = "OldestLaunchConfiguration,Default"
  description = "ECS termination policies"
}
variable "VPC_SUBNETS" {
  default     = ""
  description = "VPC subnets"
}

# ---------------------------------------------------------
# Cloud Watch
# ---------------------------------------------------------
variable "LOG_GROUP" {
  default     = ""
  description = "Log Group to be used by your AWS Instance running on a cluster"
}

# ---------------------------------------------------------
# Security Group
# ---------------------------------------------------------
variable "ENABLE_SSH" {
  default     = false
  description = "Boolean whether to allow SSH or not"
}
variable "SSH_SG" {
  default     = ""
  description = "SSH for security group ID"
}
variable "VPC_ID" {
  default     = ""
  description = "AWS VPC ID"
}

# ---------------------------------------------------------
# IAM EC2 Role
# ---------------------------------------------------------
variable "AWS_ACCOUNT_ID" {
  default     = ""
  description = "AWS Account ID"
}
variable "AWS_REGION" {
  default     = "us-east-1"
  description = "A seperate geographic area that consist of multiple isolated availability zones"
}
