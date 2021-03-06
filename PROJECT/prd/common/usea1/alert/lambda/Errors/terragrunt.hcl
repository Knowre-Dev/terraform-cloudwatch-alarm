terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

terraform_version_constraint = ">= 0.13"

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common_info" {
  config_path = "../../../sns/alarm-to-slack/common-info"
}

inputs = {
  alarm_name          = "Lambda Errors"
  alarm_description   = "Lambda Errors"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Lambda"
  metric_name         = "Errors"
  statistic           = "Sum"

  dimensions = {
    "[locian-rest-prd]]" = {
      FunctionName = "locian-rest-prd"
    },
    "[us-school-plus-graphql-prd]" = {
      FunctionName = "us-school-plus-graphql-prd"
    },
    "[us-school-plus-oauth-prd]" = {
      FunctionName = "us-school-plus-oauth-prd"
    }
  }

  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  # threshold_warn           = 0
  # ok_actions_warn          = false
  # alarm_actions_warn       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]

  threshold_crit           = 10
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common_info.outputs.sns_topic_arn]
}

