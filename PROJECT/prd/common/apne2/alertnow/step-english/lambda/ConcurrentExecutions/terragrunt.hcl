terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/generic_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../sns/alertnow/step-english/topic"
}

inputs = {
  alarm_name          = "[AlertNow] Lambda ConcurrentExecutions [StepEnglish]"
  alarm_description   = "[AlertNow] Lambda ConcurrentExecutions [StepEnglish]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Lambda"
  metric_name         = "ConcurrentExecutions"
  statistic           = "Maximum"

  treat_missing_data  = "notBreaching"

  dimensions = {
   "[API]" = {
	   FunctionName = "hexagon-api-prd"
    },
   "[ExternalAPI]" = {
	   FunctionName = "hexagon-external-api-prd"
    }
  }

  threshold_crit           = 60
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
}

