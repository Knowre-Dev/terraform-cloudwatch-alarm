terraform {
  source = "../../../../../../../../../../SERVICE/cloudwatch/metric/alarm/expression_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common_info" {
  config_path = "../../../../../../sns/alarm-to-slack/common-info"
}

inputs = {
  alarm_name          = "[dky-stable] Scale Event"
  alarm_description   = "[dky-stable] Scale Event"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "SampleCount"

  query = {
    id                = "e1"
    expression        = "ABS(DIFF(m1))"
    label             = "Scale Event"
  }
  metric_query = [
    {
      metric_name     = "CPUUtilization"
      dimension       = {
        ClusterName: "krdky"
        ServiceName: "krdky-stable"
      }
    }
  ]

  enable_info              = true
  threshold_info           = 1
  ok_actions_info          = false
  alarm_actions_info       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]
}

