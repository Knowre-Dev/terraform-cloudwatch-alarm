provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "chatbot_slack" {
  source  = "DNXLabs/chatbot/aws"
  version = "2.0.0"

  alarm_sns_topic_arns  = var.alarm_sns_topic_arns
  enabled               = var.enabled
  org_name              = var.org_name
  slack_channel_id      = var.slack_channel_id
  slack_workspace_id    = var.slack_workspace_id
  workspace_name        = var.workspace_name
  tags                  = var.tags
}
