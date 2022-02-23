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

variable "name" {
  description = "Name  (e.g. `app` or `cluster`)"
  type        = string
}

variable "env" {
  description = "Env (e.g. `prod`, `dev`, `staging`)"
  type        = string
}

variable "region_code" {
  type        = string
  default     = ""
  description = "Region Code, e.g. 'apne2', 'apne1', 'usea1'"
}

variable "role" {
  description = "service category"
  type        = string
}

variable "country" {
  description = "country (e.g. `kr` or `us` or `glb`)"
  type        = string
  default     = "glb"
}

variable "enabled" {
  type        = string
  description = "Whether to create the resources. Set to `false` to prevent the module from creating any resources"
  default     = "true"
}

variable "sns_topic" {
  type        = string
  description = "Target SNS ARN"
  default     = ""
}

variable "event_pattern" {
  description = "cloudwatch event bridge event pattern"
  type        = string
}