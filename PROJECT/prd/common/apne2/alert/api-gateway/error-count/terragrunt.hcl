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
    "[codebuild-webhook]" = {
      ApiName         = "codebuild-webhook"
      Stage           = "service"
    },
    "[management-oauth]" = {
      ApiName         = "management-oauth"
      Stage           = "service"
    },
    "[summit-score-extra-prd]" = {
      ApiName         = "summit-score-extra-prd"
      Stage           = "service"
    },
    "[management-build-log]" = {
      ApiName         = "management-build-log"
      Stage           = "service"
    },
    "[summit-score-tts-prd]" = {
      ApiName         = "summit-score-tts-prd"
      Stage           = "service"
    },
    "[locian2-csrv-api-prd]" = {
      ApiName         = "locian2-csrv-api-prd"
      Stage           = "service"
    },
    "[summit-score-admin-prd]" = {
      ApiName         = "summit-score-admin-prd"
      Stage           = "service"
    },
    "[summit-score-growth-study-prd]" = {
      ApiName         = "summit-score-growth-study-prd"
      Stage           = "service"
    },
    "[management-graphql]" = {
      ApiName         = "management-graphql"
      Stage           = "service"
    },
    "[trinity-league-rest-prd]" = {
      ApiName         = "trinity-league-rest-prd"
      Stage           = "service"
    },
    "[trinity-user-prd]" = {
      ApiName         = "trinity-user-prd"
      Stage           = "service"
    },
    "[marketing-kr-prd]" = {
      ApiName         = "marketing-kr-prd"
      Stage           = "service"
    },
    "[locian2-ucms-graphql]" = {
      ApiName         = "locian2-ucms-graphql"
      Stage           = "service"
    },
    "[datacentral-metric-api-graphql-prd-sl]" = {
      ApiName         = "datacentral-metric-api-graphql-prd-sl"
      Stage           = "service"
    },
    "[hexagon-api-prd]" = {
      ApiName         = "hexagon-api-prd"
      Stage           = "service"
    },
    "[locian2-ccms-graphql]" = {
      ApiName         = "locian2-ccms-graphql"
      Stage           = "service"
    },
    "[hexagon-external-api-prd]" = {
      ApiName         = "hexagon-external-api-prd"
      Stage           = "service"
    }
  }

  enable_crit              = true
  threshold_crit           = 20
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

