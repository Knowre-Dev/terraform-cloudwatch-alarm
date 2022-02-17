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
  # unit                      = var.unit
  # period                    = var.period
  # datapoints_to_alarm       = var.datapoints_to_alarm

  # namespace                 = var.cw_namespace
  # metric_name               = var.metric_name
  # statistic                 = var.statistic

  # dimensions                = var.dimensions
  # treat_missing_data        = var.treat_missing_data
  
  metric_query {
    id          = var.metric_query.id
    expression  = var.metric_query.expression
    label       = var.metric_query.label
    return_data = "true"
  }

  dynamic "metric_query" {
    for_each = var.query_dimensions
    content {
      id            = "m${metric_query.key + 1}"
      metric  {
        metric_name = var.metric_name
        namespace   = var.cw_namespace
        period      = var.period
        stat        = var.statistic
        unit        = var.unit

        dimensions = lookup(metric_query.value, "dimension", null)
      }
    }
  }

  threshold                 = var.threshold_crit
  alarm_actions             = var.alarm_actions_crit
  ok_actions                = var.ok_actions_crit ? var.alarm_actions_crit : []
  extended_statistic        = var.extended_statistic
  insufficient_data_actions = var.insufficient_data_actions
  tags                      = var.tags
}

# module "metric_alarms_crit" {
#   source                    = "clouddrove/cloudwatch-alarms/aws"
#   version                   = "0.15.0"

#   count                     = local.enable_crit ? 1 : 0

#   name                      = "[CRIT]${var.alarm_name}"
#   alarm_description         = "[CRIT]${var.alarm_description}"
#   comparison_operator       = var.comparison_operator
#   expression_enabled        = true
#   evaluation_periods        = var.evaluation_periods
#   period                    = var.period

#   # treat_missing_data        = var.treat_missing_data
#   query_expressions         = [{
#     id          = "e1"
#     expression  = "ANOMALY_DETECTION_BAND(m1)"
#     label       = "CPUUtilization (Expected)"
#     return_data = "true"
#   }]

#   query_metrics             = [{
#     id          = "m1"
#     return_data = "true"
#     metric_name = "CPUUtilization"
#     namespace   = "AWS/EC2"
#     period      = "120"
#     stat        = "Average"
#     unit        = "Count"
#     dimensions  = {
#       InstanceId = module.ec2.instance_id[0]
#     }
#   }]

#   alarm_actions             = local.alarm_actions_crit
#   ok_actions                = var.ok_actions_crit ? local.alarm_actions_crit : null #local.ok_actions_crit ? local.alarm_actions_crit : null
#   extended_statistic        = var.extended_statistic
#   tags                      = var.tags
#   insufficient_data_actions = var.insufficient_data_actions
# }
