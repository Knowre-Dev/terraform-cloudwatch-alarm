variable "aws_region" {
  type = string
}

variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

# variable "enabled" {
#   type        = "string"
#   description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
#   default     = "true"
# }

# variable "tags" {
#   type        = map(string)
#   default     = {}
#   description = "Additional tags (e.g. `map('BusinessUnit`,`XYZ`)"
# }

variable "org_name" {
  description = "Name for this organization"
}
variable "workspace_name" {
  description = "Description for the chat integration"
}
variable "enabled" {
  description = "If true, will create aws chatboot and integrate to slack"
  default     = "false"
}
variable "slack_channel_id" {
  description = "Slack channel id to send budget notfication using AWS Chatbot"
  default     = ""
}
variable "slack_workspace_id" {
  description = "Slack workspace id to send budget notfication using AWS Chatbot"
  default     = ""
}
# variable "alarm_sns_topic_arn" {
#   description = "SNS Topic ARN to connect to AWS Chatbot"
# }

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}

##############################################################
######################## Remote State ########################
variable "bucket" {
  type = string
}

variable "config_region" {
  type = string
}

variable "dynamodb_table" {
  type = string
}

variable "alarm_sns_topic_arns" {
  description = "ARN of SNS Topic(s) to connect to AWS Chatbot"
  # list of string (accept string for backwards compatibility)
  type = any
}
