terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/expression_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common_info" {
  config_path = "../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "[Fargate] vCPU Limit"
  alarm_description   = "[Fargate] vCPU Limit"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Usage"
  statistic           = "Maximum"

  query = {
    id                = "e1"
    expression        = "(m1/SERVICE_QUOTA(m1))*100"
    label             = "vCPU Limit Usage"
  }
  metric_query = [
    {
      metric_name     = "ResourceCount"
      dimension       = {
        Service   = "Fargate"
        Resource  = "vCPU"
        Type      = "Resource"
        Class     = "Standard/OnDemand"
      }
    }
  ]

  # enable_info              = false
  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  enable_warn              = true
  threshold_warn           = 70
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 90
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]

}

