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

  alarm_actions_info        = (var.alarm_actions_info != null ? var.alarm_actions_info : var.alarm_actions)
  alarm_actions_warn        = (var.alarm_actions_warn != null ? var.alarm_actions_warn : var.alarm_actions)
  alarm_actions_crit        = (var.alarm_actions_crit != null ? var.alarm_actions_crit : var.alarm_actions)
}


resource "aws_cloudwatch_metric_alarm" "express_alarms_info" {
  count                     = local.enable_info ? 1 : 0

  alarm_name                = "[INFO]${var.alarm_name}"
  alarm_description         = "[INFO]${var.alarm_description}"
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
  
  threshold                 = var.threshold_info
  alarm_actions             = local.alarm_actions_info
  ok_actions                = var.ok_actions_info ? local.alarm_actions_info : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
}

resource "aws_cloudwatch_metric_alarm" "express_alarms_warn" {
  count                     = local.enable_warn ? 1 : 0

  alarm_name                = "[WARN]${var.alarm_name}"
  alarm_description         = "[WARN]${var.alarm_description}"
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
  
  threshold                 = var.threshold_warn
  alarm_actions             = local.alarm_actions_warn
  ok_actions                = var.ok_actions_warn ? local.alarm_actions_warn : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
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
  alarm_actions             = local.alarm_actions_crit
  ok_actions                = var.ok_actions_crit ? local.alarm_actions_crit : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
}

