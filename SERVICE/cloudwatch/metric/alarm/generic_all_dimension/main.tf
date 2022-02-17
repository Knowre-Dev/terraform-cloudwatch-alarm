provider "aws" {
  region = var.aws_region
}

terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

locals {
  enable_info               = (var.threshold_info == null ? false : true)
  enable_warn               = (var.threshold_warn == null ? false : true)
  enable_crit               = (var.threshold_crit == null ? false : true)
}

resource "aws_cloudwatch_metric_alarm" "express_alarms_crit" {
  count                     = local.enable_crit ? 1 : 0

  alarm_name                = "[CRIT]${var.alarm_name}"
  alarm_description         = "[CRIT]${var.alarm_description}"
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  unit                      = var.unit
  period                    = var.period
  datapoints_to_alarm       = var.datapoints_to_alarm

  namespace                 = var.cw_namespace
  metric_name               = var.metric_name
  statistic                 = var.statistic

  # dimensions                = var.dimensions
  treat_missing_data        = var.treat_missing_data
  
  threshold                 = var.threshold_crit
  alarm_actions             = var.alarm_actions_crit
  ok_actions                = var.ok_actions_crit ? var.alarm_actions_crit : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
}

