terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/expression_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common_info" {
  config_path = "../../../../sns/alarm-to-slack/common-info"
}

inputs = {
  alarm_name          = "[hexagon] Error Rate"
  alarm_description   = "[hexagon] Error Rate"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 300
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  statistic           = "Sum"

  query = {
    id                = "e1"
    expression        = "(m2/(m3+0.1))*100"
    label             = "Error Rate"
  }

  metric_query = [
    {
      metric_name     = "HTTPCode_Target_4XX_Count"
      dimension       = {
        TargetGroup = "targetgroup/prd-apne2-kr-hexagon/0a205e2db192a82d"
        LoadBalancer = "app/prd-apne2-kr-hexagon-alb/a8a724c5e829860f"
      }
    },
    {
      metric_name     = "HTTPCode_Target_5XX_Count"
      dimension       = {
        TargetGroup = "targetgroup/prd-apne2-kr-hexagon/0a205e2db192a82d"
        LoadBalancer = "app/prd-apne2-kr-hexagon-alb/a8a724c5e829860f"
      }
    },
    {
      metric_name     = "RequestCount"
      dimension       = {
        TargetGroup = "targetgroup/prd-apne2-kr-hexagon/0a205e2db192a82d"
        LoadBalancer = "app/prd-apne2-kr-hexagon-alb/a8a724c5e829860f"
      }
    }
  ]

  # enable_info              = false
  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  # enable_warn              = false
  # threshold_warn           = 0
  # ok_actions_warn          = false
  # alarm_actions_warn       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 10
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]

}

