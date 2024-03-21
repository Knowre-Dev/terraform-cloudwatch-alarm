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
  alarm_name          = "[AlertNow] Lambda Errors [StepEnglish]"
  alarm_description   = "[AlertNow] Lambda Errors [StepEnglish]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Lambda"
  metric_name         = "Errors"
  statistic           = "Sum"

  dimensions = {
   "[API]" = {
	   FunctionName = "hexagon-api-prd"
    }
  }

  threshold_crit           = 10
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
}

