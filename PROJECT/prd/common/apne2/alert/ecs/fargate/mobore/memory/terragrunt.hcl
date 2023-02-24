terraform {
  source = "../../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "Fargate Memory Usage"
  alarm_description   = "Fargate Memory Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Maximum"

  dimensions = {
    "[mowbore]"     = {
      ClusterName: "mowbore"
      ServiceName: "mowbore-sl-stable"
    },
  }

  threshold_crit      = 90
  ok_actions_crit     = false
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}