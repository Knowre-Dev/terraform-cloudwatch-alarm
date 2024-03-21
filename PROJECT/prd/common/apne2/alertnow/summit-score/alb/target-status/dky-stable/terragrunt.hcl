terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/expression_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../../sns/alertnow/summit-score/topic"
}

inputs = {
  alarm_name          = "[AlertNow] Target Availability Status [SummitScore]-[API]"
  alarm_description   = "[AlertNow] Target Availability Status [SummitScore]-[API]"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  statistic           = "Average"

  query = {
    id                = "e1"
    expression        = "(m2/(m1+m2))*100"
    label             = "Target Availability Status"
  }
  metric_query = [
    {
      metric_name     = "UnHealthyHostCount"
      dimension       = {
        TargetGroup = "targetgroup/dky-stable/f06948eaf912b016"
        LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
      }
    },
    {
      metric_name     = "HealthyHostCount"
      dimension       = {
        TargetGroup = "targetgroup/dky-stable/f06948eaf912b016"
        LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
      }
    }
  ]

  # enable_info              = false
  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  enable_warn              = true
  threshold_warn           = 60
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 40
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]

}

