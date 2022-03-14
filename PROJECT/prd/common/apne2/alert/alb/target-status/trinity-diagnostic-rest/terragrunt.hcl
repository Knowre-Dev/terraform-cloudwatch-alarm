terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/expression_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_alb" {
  config_path = "../../../../sns/alarm-to-slack/alb"
}

inputs = {
  alarm_name          = "[trinity-diagnostic-rest] Target Availability Status"
  alarm_description   = "[trinity-diagnostic-rest] Target Availability Status"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
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
        TargetGroup   = "targetgroup/trinity-diagnostic-rest-prd/ed25a969422b60e2"
        LoadBalancer  = "app/trinity-diagnostic-rest-prd/0aa864ca88cfee0b"
      }
    },
    {
      metric_name     = "HealthyHostCount"
      dimension       = {
        TargetGroup   = "targetgroup/trinity-diagnostic-rest-prd/ed25a969422b60e2"
        LoadBalancer  = "app/trinity-diagnostic-rest-prd/0aa864ca88cfee0b"
      }
    }
  ]

  # enable_info              = false
  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  enable_warn              = true
  threshold_warn           = 30
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_alb.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 10
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_alb.outputs.sns_topic_arn]

}

