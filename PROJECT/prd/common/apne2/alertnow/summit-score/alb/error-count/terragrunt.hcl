terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/generic_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../sns/alertnow/summit-score/topic"
}

inputs = {
  alarm_name          = "[AlertNow] 5XX Error Count [SummitScore]"
  alarm_description   = "[AlertNow]5XX Error Count [SummitScore]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_Target_5XX_Count"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    "[API]" = {
      TargetGroup = "targetgroup/dky-stable/f06948eaf912b016"
      LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
    },
    "[CMS]" = {
      TargetGroup = "targetgroup/locian0kr-stable/504508a93e46900d"
      LoadBalancer = "app/locian0kr-stable/5118b11b02a7dad9"
    }
  }

  enable_warn              = true
  threshold_warn           = 20
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic.outputs.sns_topic_arn]

  enable_crit              = true
  threshold_crit           = 50
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
}

