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

  ok_actions_info           = ((var.alarm_actions_info != null && var.ok_actions_info == true) ?  true : ((local.enable_info == true && local.enable_warn == false && local.enable_crit == false) ? true : false))
  ok_actions_warn           = ((var.alarm_actions_warn != null && var.ok_actions_warn == true) ?  true : ((local.enable_warn == true && local.enable_info == false) ? true : false))
  ok_actions_crit           = ((var.alarm_actions_crit != null && var.ok_actions_crit == true) ?  true : ((local.enable_crit == true && local.enable_info == false && local.enable_warn == false) ? true : false))

  alarm_actions_info        = (var.alarm_actions_info != null ? var.alarm_actions_info : var.alarm_actions)
  alarm_actions_warn        = (var.alarm_actions_warn != null ? var.alarm_actions_warn : var.alarm_actions)
  alarm_actions_crit        = (var.alarm_actions_crit != null ? var.alarm_actions_crit : var.alarm_actions)
}

module "metric_alarms_info" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarms-by-multiple-dimensions"
  version = "~> 1.0"

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

  dimensions                = var.dimensions
  treat_missing_data        = var.treat_missing_data

  threshold                 = var.threshold_info
  alarm_actions             = local.alarm_actions_info
  ok_actions                = local.ok_actions_info ? local.alarm_actions_info : []
  insufficient_data_actions = var.insufficient_data_actions
  extended_statistic        = var.extended_statistic
  tags                      = var.tags
}

module "metric_alarms_warn" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarms-by-multiple-dimensions"
  version = "~> 1.0"

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

  dimensions                = var.dimensions
  treat_missing_data        = var.treat_missing_data

  threshold                 = var.threshold_warn
  alarm_actions             = local.alarm_actions_warn
  ok_actions                = local.ok_actions_warn ? local.alarm_actions_warn : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
}

module "metric_alarms_crit" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarms-by-multiple-dimensions"
  version = "~> 1.0"

  count                     = local.enable_crit ? 1 : 0

  alarm_name                = "[CRIT]${var.alarm_name}"
  alarm_description         = "[CRIT]${var.alarm_description}"
  comparison_operator       = var.comparison_operator
  evaluation_periods        = var.evaluation_periods
  threshold                 = var.threshold_crit
  unit                      = var.unit
  period                    = var.period
  datapoints_to_alarm       = var.datapoints_to_alarm

  namespace                 = var.cw_namespace
  metric_name               = var.metric_name
  statistic                 = var.statistic

  dimensions                = var.dimensions
  treat_missing_data        = var.treat_missing_data

  alarm_actions             = local.alarm_actions_crit
  ok_actions                = var.ok_actions_crit ? local.alarm_actions_crit : null #local.ok_actions_crit ? local.alarm_actions_crit : null
  extended_statistic        = var.extended_statistic
  tags                      = var.tags
  insufficient_data_actions = var.insufficient_data_actions
}
