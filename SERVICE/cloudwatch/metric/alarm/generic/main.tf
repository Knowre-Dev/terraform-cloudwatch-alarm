provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

module "metric_alarms" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 1.0"

  alarm_name          = var.alarm_name
  alarm_description   = var.alarm_description
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  threshold           = var.threshold
  unit                = var.unit
  period              = var.period
  datapoints_to_alarm = var.datapoints_to_alarm

  namespace           = var.cw_namespace
  metric_name         = var.metric_name
  statistic           = var.statistic

  dimensions          = var.dimensions

  alarm_actions       = [data.terraform_remote_state.sns_topic_arn.outputs.sns_topic_arn]
  ok_actions          = var.ok_actions ? [data.terraform_remote_state.sns_topic_arn.outputs.sns_topic_arn] : []
  insufficient_data_actions = var.insufficient_data_actions ? [data.terraform_remote_state.sns_topic_arn.outputs.sns_topic_arn] : []
  extended_statistic  = var.extended_statistic
  tags                = var.tags
}
