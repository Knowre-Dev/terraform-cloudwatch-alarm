terraform {
  source = "../../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path         = "../../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "502 Server Error"
  alarm_description   = "502 Server Error"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_502_Count"
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
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

