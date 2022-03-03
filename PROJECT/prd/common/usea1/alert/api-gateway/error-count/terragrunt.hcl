terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path         = "../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "5XX Error Count"
  alarm_description   = "5XX Error Count"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApiGateway"
  metric_name         = "5XXError"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    "[locian-rest-prd]" = {
      ApiName         = "locian-rest-prd"
      Stage           = "service"
    },
    "[us-school-plus-graphql-prd]" = {
      ApiName         = "us-school-plus-graphql-prd"
      Stage           = "service"
    },
    "[us-school-plus-oauth-prd]" = {
      ApiName         = "us-school-plus-oauth-prd"
      Stage           = "service"
    }
  }

  enable_crit              = true
  threshold_crit           = 20
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

