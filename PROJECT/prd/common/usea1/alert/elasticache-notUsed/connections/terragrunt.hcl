terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension/"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name        = "ElastiCache-REDIS Connections"
  alarm_description = "ElastiCache-REDIS Connections"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace   = "AWS/ElastiCache"
  metric_name = "CurrConnections"
  statistic   = "Maximum"

  dimensions = {
    "[nv-common-navy-prd-001]" = {
      CacheClusterId: "sl-dky-data-navy-prd-001"
    },
    "[nv-common-navy-prd-002]" = {
      CacheClusterId: "sl-dky-data-navy-prd-002"
    }
  }

  threshold_warn           = 30000
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit           = 40000
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}