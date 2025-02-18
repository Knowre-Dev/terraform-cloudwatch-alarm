terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common_info" {
  config_path = "../../../sns/alarm-to-slack/common-info"
}

inputs = {
  alarm_name          = "API Gateway IntegrationLatency"
  alarm_description   = "API Gateway IntegrationLatency"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Milliseconds"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApiGateway"
  metric_name         = "IntegrationLatency"
  statistic           = "Average"

  treat_missing_data  = "notBreaching"

  dimensions = {
    "[locian-rest-prd]" = {
      ApiName         = "locian-rest-prd"
    },
    "[us-school-plus-graphql-prd]" = {
      ApiName         = "us-school-plus-graphql-prd"
    },
    "[us-school-plus-oauth-prd]" = {
      ApiName         = "us-school-plus-oauth-prd"
    }
  }


  # threshold_warn      = 2000
  # ok_actions_warn     = false
  # alarm_actions_warn  = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit      = 20000
  ok_actions_crit     = false
  alarm_actions_crit  = [dependency.sns_topic_common_info.outputs.sns_topic_arn]
}