terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "Lambda ConcurrentExecutions"
  alarm_description   = "Lambda ConcurrentExecutions"
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
   "[summit-score-push-prd]" = {
	   FunctionName = "summit-score-push-prd"
    }
  }

  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  # threshold_warn           = 0
  # ok_actions_warn          = false
  # alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit           = 220
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
}

