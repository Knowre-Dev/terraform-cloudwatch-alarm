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

resource "aws_cloudwatch_metric_alarm" "express_alarms_crit" {
  count                     = local.enable_crit ? 1 : 0

  dynamic "expression_query" {
    for_each = var.query_dimensions
    contents {
      alarm_name                = "[CRIT]${var.alarm_name}"
      alarm_description         = "[CRIT]${var.alarm_description}"
      comparison_operator       = var.comparison_operator
      evaluation_periods        = var.evaluation_periods

      metric_query {
        id          = var.metric_query.id
        expression  = var.metric_query.expression
        label       = var.metric_query.label
        return_data = "true"
      }

      metric_query {
        id = "m1"

        metric {
          metric_name = var.metric_query.metric_name_m1
          namespace   = var.cw_namespace
          period      = var.period
          stat        = var.statistic
          unit        = var.unit

          dimensions = lookup(expression_query.value, "dimension", null)
        }
      }

      metric_query {
        id = "m2"

        metric {
          metric_name = var.metric_query.metric_name_m1
          namespace   = var.cw_namespace
          period      = var.period
          stat        = var.statistic
          unit        = var.unit

          dimensions = lookup(expression_query.value, "dimension", null)
        }
      }

      threshold                 = var.threshold_crit
      alarm_actions             = local.alarm_actions_crit
      ok_actions                = var.ok_actions_crit ? local.alarm_actions_crit : []
      extended_statistic        = var.extended_statistic
      insufficient_data_actions = var.insufficient_data_actions
      tags                      = var.tags
    }
  }
}
