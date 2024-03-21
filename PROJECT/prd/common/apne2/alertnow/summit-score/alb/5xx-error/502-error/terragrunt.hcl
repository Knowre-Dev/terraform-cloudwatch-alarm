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
  alarm_name          = "[AlertNow] 502 Server Error [SummitScore]"
  alarm_description   = "[AlertNow] 502 Server Error [SummitScore]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_502_Count"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    "[API]" = {
      LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
    },
    "[CMS]" = {
      LoadBalancer = "app/locian0kr-stable/5118b11b02a7dad9"
    },
  }

  enable_crit              = true
  threshold_crit           = 10
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

