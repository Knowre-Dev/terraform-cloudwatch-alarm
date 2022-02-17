##############################################################
########################## Common ############################
variable "aws_region" {
  type = string
}

##############################################################
############################ Tags ############################
variable "attributes" {
  type        = list
  default     = []
  description = "Additional attributes (e.g. `policy` or `role`)"
}

variable "tags" {
  type        = map
  default     = {}
  description = "Additional tags (e.g. map('BusinessUnit`,`XYZ`)"
}

variable "namespace" {
  description = "Namespace (e.g. `cp` or `cloudposse`)"
  type        = string
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "stage" {
  description = "Stage (e.g. `prod`, `dev`, `staging`)"
  type        = string
}

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = string
}

variable "enabled" {
  type        = string
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = "true"
}


##############################################################
########################## lambda ############################
variable "sns_topic" {
  type        = string
  description = "Target SNS ARN"
  default     = ""
}

#variable "slack_webhook_url" {
#  description = "Needs to be encrypted from a file with _no_ encryption context, using: aws kms encrypt --key-id 'arn:' --plaintext 'fileb://webhook' --output text --query CiphertextBlob"
#}

#variable "slack_channel" {
#  description = "E.g. #channel_name"
#}


#variable "notify_users" {
#  description = "Slack usernames for mentions as a space separated string as '<@name1> <@name2>' or '<!channel>' or '<!here>'"
#  type        = "string"
#  default     = ""
#}