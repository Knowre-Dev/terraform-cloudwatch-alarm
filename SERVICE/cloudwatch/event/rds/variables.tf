variable "aws_region" {
  type = string
}

variable "name" {
  type    = string
  default = null
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "sns_topic" {
  type = string
}

variable "source_ids" {
  type        = list(string)
  default     = null
}

variable "source_type" {
  type    = string
  default = null
}

variable "event_categories" {
  type        = list(string)
  default     = null
}

# Tags
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

variable "tags" {
  description = "Specifies object tags key and value. This applies to all resources created by this module."
  default = {
    "Terraform" = true
  }
}

variable "enabled" {
  type = bool
  default = true
}
