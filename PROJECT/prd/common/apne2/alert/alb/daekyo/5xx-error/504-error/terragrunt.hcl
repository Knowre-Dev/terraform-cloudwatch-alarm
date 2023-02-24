terraform {
  source = "../../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path         = "../../../../../sns/alarm-to-slack/common"
}

dependency "sns_topic_server" {
  config_path         = "../../../../../sns/alarm-to-slack/server"
}

inputs = {
  alarm_name          = "504 Server Error"
  alarm_description   = "504 Server Error"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_504_Count"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    "[dky]" = {
      LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
    }
  }

  enable_crit              = true
  threshold_crit           = 1
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn, dependency.sns_topic_server.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

