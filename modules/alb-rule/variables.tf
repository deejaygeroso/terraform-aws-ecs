variable "LISTENER_ARN" {
  default     = ""
  description = "The ARN of the listener to which to attach the rule"
}

variable "PRIORITY" {
  default     = ""
  description = "The priority for the rule between 1 and 50000. Leaving it unset will automatically set the rule with next available priority after currently existing highest rule. A listener can't have multiple rules with the same priority"
}

variable "TARGET_GROUP_ARN" {
  default     = ""
  description = "The ARN of the Target Group to which to route traffic. Specify only if type is forward and you want to route to a single target group. To route to one or more target groups, use a forward block instead"
}

variable "CONDITION_FIELD" {
  default     = ""
  description = "Condition field"
}

variable "CONDITION_VALUES" {
  type        = list(string)
  description = "Condition values"
}
