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
  alarm_name          = "ElastiCache-REDIS CPU Usage"
  alarm_description   = "ElastiCache-REDIS CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ElastiCache"
  metric_name         = "CPUUtilization"
  statistic           = "Maximum"

  dimensions = {
    "[sl-dky-navy-prd-001]" = {
      CacheClusterId: "sl-dky-navy-prd-001"
    },
    "[sl-dky-navy-prd-002]" = {
      CacheClusterId: "sl-dky-navy-prd-002"
    },
    "[sl-trinity-answer-navy-prd-001]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-001"
    },
    "[sl-trinity-answer-navy-prd-002]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-002"
    },
    "[sl-school-answer-navy-prd-001]" = {
      CacheClusterId: "sl-school-answer-navy-prd-001"
    },
    "[sl-school-answer-navy-prd-002]" = {
      CacheClusterId: "sl-school-answer-navy-prd-002"
    },
    "[sl-school-session-navy-prd-001]" = {
      CacheClusterId: "sl-school-session-navy-prd-001"
    },
    "[sl-school-session-navy-prd-002]" = {
      CacheClusterId: "sl-school-session-navy-prd-002"
    }
  }

  threshold_crit           = 45
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}