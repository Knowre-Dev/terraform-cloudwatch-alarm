terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../sns/alarm-to-slack/common"
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

  dimensions = {
    "[codebuild-webhook]" = {
      ApiName         = "codebuild-webhook"
    },
    "[management-oauth]" = {
      ApiName         = "management-oauth"
    },
    "[summit-score-extra-prd]" = {
      ApiName         = "summit-score-extra-prd"
    },
    "[management-build-log]" = {
      ApiName         = "management-build-log"
    },
    "[summit-score-tts-prd]" = {
      ApiName         = "summit-score-tts-prd"
    },
    "[locian2-csrv-api-prd]" = {
      ApiName         = "locian2-csrv-api-prd"
    },
    "[summit-score-admin-prd]" = {
      ApiName         = "summit-score-admin-prd"
    },
    "[summit-score-growth-study-prd]" = {
      ApiName         = "summit-score-growth-study-prd"
    },
    "[management-graphql]" = {
      ApiName         = "management-graphql"
    },
    "[trinity-league-rest-prd]" = {
      ApiName         = "trinity-league-rest-prd"
    },
    "[trinity-user-prd]" = {
      ApiName         = "trinity-user-prd"
    },
    "[marketing-kr-prd]" = {
      ApiName         = "marketing-kr-prd"
    },
    "[locian2-ucms-graphql]" = {
      ApiName         = "locian2-ucms-graphql"
    },
    "[datacentral-metric-api-graphql-prd-sl]" = {
      ApiName         = "datacentral-metric-api-graphql-prd-sl"
    },
    "[hexagon-api-prd]" = {
      ApiName         = "hexagon-api-prd"
    },
    "[locian2-ccms-graphql]" = {
      ApiName         = "locian2-ccms-graphql"
    },
    "[hexagon-external-api-prd]" = {
      ApiName         = "hexagon-external-api-prd"
    }
  }


  threshold_warn      = 2000
  ok_actions_warn     = true
  alarm_actions_warn  = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit      = 5000
  ok_actions_crit     = true
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}