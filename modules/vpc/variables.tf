variable "ENV" {
  default     = "stage"
  description = "Project environment: dev, stage or prod"
}

variable "AWS_REGION" {
  default     = "us-east-1"
  description = "A seperate geographic area that consist of multiple isolated availability zones"
}

variable "CIDR" {
  default     = "10.0.0.0/16"
  description = "The CIDR block for the VPC"
}

variable "PRIVATE_SUBNETS" {
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  description = "Private CIDR blocks for your availabilty zones"
  type        = list
}

variable "PUBLIC_SUBNETS" {
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  description = "Public CIDR blocks for your availabilty zones"
  type        = list
}
