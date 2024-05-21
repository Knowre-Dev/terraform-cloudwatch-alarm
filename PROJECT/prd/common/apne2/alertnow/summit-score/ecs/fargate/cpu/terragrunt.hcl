terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/generic_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../../sns/alertnow/summit-score/topic"
}

inputs = {
  alarm_name          = "[AlertNow] Fargate CPU Usage [SummitScore]"
  alarm_description   = "[AlertNow] Fargate CPU Usage [SummitScore]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"

  dimensions = {
    "[API]"     = {
      ClusterName: "krdky"
      ServiceName: "krdky-stable"
    },
    "[CMS]"     = {
      ClusterName: "locian0kr"
      ServiceName: "locian0kr-stable"
    }
  }

  threshold_warn      = 60
  ok_actions_warn     = true
  alarm_actions_warn  = [dependency.sns_topic.outputs.sns_topic_arn]

  threshold_crit      = 90
  ok_actions_crit     = true
  alarm_actions_crit  = [dependency.sns_topic.outputs.sns_topic_arn]
}