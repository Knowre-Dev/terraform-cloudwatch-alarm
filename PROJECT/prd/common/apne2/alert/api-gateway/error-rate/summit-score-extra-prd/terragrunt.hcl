terraform {
  source = "../../../../../../../../../SERVICE/cloudwatch/metric/alarm/expression_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "[dky] 5XX Error Rate"
  alarm_description   = "[dky] 5XX Error Rate"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Lambda"
  statistic           = "Sum"

  query = {
    id                = "e1"
    expression        = "(m1/m2)*100"
    label             = "5XX Error Rate"
  }
  metric_query = [
    {
      metric_name     = "5XXError"
      dimension       = {
        ApiName         = "summit-score-extra-prd"
        Stage           = "service"
      }
    },
    {
      metric_name     = "RequestCount"
      dimension       = {
        ApiName         = "summit-score-extra-prd"
        Stage           = "service"
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
  # alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 10
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]

}

