terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "ElastiCache-REDIS Memory Usage"
  alarm_description   = "ElastiCache-REDIS Memory Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ElastiCache"
  metric_name         = "DatabaseMemoryUsagePercentage"
  statistic           = "Maximum"

  dimensions = {
    "[sl-dky-data-navy-001]" = {
      CacheClusterId: "sl-dky-data-navy-prd-001"
    },
    "[sl-dky-data-navy-002]" = {
      CacheClusterId: "sl-dky-data-navy-prd-002"
    },
    "[sl-dky-navy-prd-001]" = {
      CacheClusterId: "sl-dky-navy-prd-001"
    },
    "[sl-dky-navy-prd-002]" = {
      CacheClusterId: "sl-dky-navy-prd-002"
    },
    "[sl-jarvis-auth-navy-prd-001]" = {
      CacheClusterId: "sl-jarvis-auth-navy-prd-001"
    },
    "[sl-jarvis-auth-navy-prd-002]" = {
      CacheClusterId: "sl-jarvis-auth-navy-prd-002"
    },
    "[sl-trinity-answer-navy-prd-001]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-001"
    },
    "[sl-trinity-answer-navy-prd-002]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-002"
    }
  }

  threshold_warn           = 60
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit           = 70
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}