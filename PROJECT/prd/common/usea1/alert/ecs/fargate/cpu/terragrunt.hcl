terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "Fargate CPU Usage"
  alarm_description   = "Fargate CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"

  dimensions = {
    "[locian0us-usp]"     = {
      ClusterName: "locian0us-usp"
      ServiceName: "locian0us-usp-stable"
    },
    "[mowbore]"     = {
      ClusterName: "mowbore"
      ServiceName: "mowbore-nv-stable"
    }
  }

  threshold_crit      = 90
  ok_actions_crit     = true
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}