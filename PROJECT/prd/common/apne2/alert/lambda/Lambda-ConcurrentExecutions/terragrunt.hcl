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
   "[ECSEventsLogsToCloudWatch]" = {
	   FunctionName = "ECSEventsLogsToCloudWatch"
   },
   "[codebuild-noti]" = {
	   FunctionName = "codebuild-noti"
   },
   "[codebuild-webhook]" = {
	   FunctionName = "codebuild-webhook"
    },
   "[datacentral-glue-event-watcher-dev]" = {
	   FunctionName = "datacentral-glue-event-watcher-dev"
    },
   "[datacentral-metric-api-graphql-dev]" = {
	   FunctionName = "datacentral-metric-api-graphql-dev"
    },
   "[datacentral-metric-api-graphql-prd-sl]" = {
	   FunctionName = "datacentral-metric-api-graphql-prd-sl"
    },
   "[datacentral-metric-api-graphql-stg]" = {
	   FunctionName = "datacentral-metric-api-graphql-stg"
    },
   "[datacentral-stream-cwl-dev-01-sl]" = {
	   FunctionName = "datacentral-stream-cwl-dev-01-sl"
    },
   "[datacentral-stream-cwl-dev-02-sl]" = {
	   FunctionName = "datacentral-stream-cwl-dev-02-sl"
    },
   "[datacentral-stream-cwl-dev-03-sl]" = {
	   FunctionName = "datacentral-stream-cwl-dev-03-sl"
    },
   "[datacentral-stream-cwl-dev-04-sl]" = {
	   FunctionName = "datacentral-stream-cwl-dev-04-sl"
    },
   "[datacentral-stream-cwl-prd-01-sl]" = {
	   FunctionName = "datacentral-stream-cwl-prd-01-sl"
    },
   "[datacentral-stream-cwl-prd-02-sl]" = {
	   FunctionName = "datacentral-stream-cwl-prd-02-sl"
    },
   "[datacentral-stream-cwl-prd-03-sl]" = {
	   FunctionName = "datacentral-stream-cwl-prd-03-sl"
    },
   "[datacentral-stream-cwl-prd-04-sl]" = {
	   FunctionName = "datacentral-stream-cwl-prd-04-sl"
    },
   "[datacentral-stream-cwl-stg-01-sl]" = {
	   FunctionName = "datacentral-stream-cwl-stg-01-sl"
    },
   "[datacentral-stream-cwl-stg-02-sl]" = {
	   FunctionName = "datacentral-stream-cwl-stg-02-sl"
    },
   "[datacentral-stream-cwl-stg-03-sl]" = {
	   FunctionName = "datacentral-stream-cwl-stg-03-sl"
    },
   "[datacentral-stream-cwl-stg-04-sl]" = {
	   FunctionName = "datacentral-stream-cwl-stg-04-sl"
    },
   "[dev-apne2-kr-hexagon-infra-automation-lambda]" = {
	   FunctionName = "dev-apne2-kr-hexagon-infra-automation-lambda"
    },
   "[dev-apne2-kr-summit-infra-automation-lambda]" = {
	   FunctionName = "dev-apne2-kr-summit-infra-automation-lambda"
    },
   "[email-sender]" = {
	   FunctionName = "email-sender"
    },
   "[hexagon-api-dev]" = {
	   FunctionName = "hexagon-api-dev"
    },
   "[hexagon-api-prd]" = {
	   FunctionName = "hexagon-api-prd"
    },
   "[hexagon-api-preprd]" = {
	   FunctionName = "hexagon-api-preprd"
    },
   "[hexagon-api-shcho-test]" = {
	   FunctionName = "hexagon-api-shcho-test"
    },
   "[hexagon-api-stg]" = {
	   FunctionName = "hexagon-api-stg"
    },
   "[hexagon-external-api-dev]" = {
	   FunctionName = "hexagon-external-api-dev"
    },
   "[hexagon-external-api-prd]" = {
	   FunctionName = "hexagon-external-api-prd"
    },
   "[hexagon-external-api-preprd]" = {
	   FunctionName = "hexagon-external-api-preprd"
    },
   "[hexagon-external-api-stg]" = {
	   FunctionName = "hexagon-external-api-stg"
    },
   "[knowre-school-home-email-provider]" = {
	   FunctionName = "knowre-school-home-email-provider"
    },
   "[knowre-school-home-email-provider-development]" = {
	   FunctionName = "knowre-school-home-email-provider-development"
    },
   "[locian-rest-dev]" = {
	   FunctionName = "locian-rest-dev"
    },
   "[locian2-ccms-graphql]" = {
	   FunctionName = "locian2-ccms-graphql"
    },
   "[locian2-csrv-api-dev]" = {
	   FunctionName = "locian2-csrv-api-dev"
    },
   "[locian2-csrv-api-prd]" = {
	   FunctionName = "locian2-csrv-api-prd"
    },
   "[locian2-csrv-api-stg]" = {
	   FunctionName = "locian2-csrv-api-stg"
    },
   "[locian2-ucms-graphql]" = {
	   FunctionName = "locian2-ucms-graphql"
    },
   "[management-graphql]" = {
	   FunctionName = "management-graphql"
    },
   "[management-oauth]" = {
	   FunctionName = "management-oauth"
    },
   "[prd-apne2-kr-cwlog-parser-lambda]" = {
	   FunctionName = "prd-apne2-kr-cwlog-parser-lambda"
    },
   "[prd-apne2-kr-rds-cost-notice-lambda]" = {
	   FunctionName = "prd-apne2-kr-rds-cost-notice-lambda"
    },
   "[prd-apne2-kr-slack-user-notice-lambda]" = {
	   FunctionName = "prd-apne2-kr-slack-user-notice-lambda"
    },
   "[prd-apne2-kr-slowquery-parser-lambda]" = {
	   FunctionName = "prd-apne2-kr-slowquery-parser-lambda"
    },
   "[scheduler-bardeg]" = {
	   FunctionName = "scheduler-bardeg"
    },
   "[scheduler-dead-mans-switch]" = {
	   FunctionName = "scheduler-dead-mans-switch"
    },
   "[scheduler-deps-mgmt]" = {
	   FunctionName = "scheduler-deps-mgmt"
    },
   "[scheduler-docker-task]" = {
	   FunctionName = "scheduler-docker-task"
    },
   "[scheduler-hexagon-batch]" = {
	   FunctionName = "scheduler-hexagon-batch"
    },
   "[scheduler-invalidation-cloudfront]" = {
	   FunctionName = "scheduler-invalidation-cloudfront"
    },
   "[scheduler-merge-branch]" = {
	   FunctionName = "scheduler-merge-branch"
    },
   "[scheduler-recreate-branch]" = {
	   FunctionName = "scheduler-recreate-branch"
    },
   "[scheduler-scale-aurora]" = {
	   FunctionName = "scheduler-scale-aurora"
    },
   "[scheduler-scale-task]" = {
	   FunctionName = "scheduler-scale-task"
    },
   "[scheduler-url-call]" = {
	   FunctionName = "scheduler-url-call"
    },
   "[sns-event-noti]" = {
	   FunctionName = "sns-event-noti"
    },
   "[stg-apne2-kr-hexagon-infra-automation-lambda]" = {
	   FunctionName = "stg-apne2-kr-hexagon-infra-automation-lambda"
    },
   "[stg-apne2-kr-summit-infra-automation-lambda]" = {
	   FunctionName = "stg-apne2-kr-summit-infra-automation-lambda"
    },
   "[summit-score-admin-dev]" = {
	   FunctionName = "summit-score-admin-dev"
    },
   "[summit-score-admin-prd]" = {
	   FunctionName = "summit-score-admin-prd"
    },
   "[summit-score-admin-stg]" = {
	   FunctionName = "summit-score-admin-stg"
    },
   "[summit-score-contentsqa-dev]" = {
	   FunctionName = "summit-score-contentsqa-dev"
    },
   "[summit-score-extra-dev]" = {
	   FunctionName = "summit-score-extra-dev"
    },
   "[summit-score-extra-prd]" = {
	   FunctionName = "summit-score-extra-prd"
    },
   "[summit-score-extra-stg]" = {
	   FunctionName = "summit-score-extra-stg"
    },
   "[summit-score-growth-study-dev]" = {
	   FunctionName = "summit-score-growth-study-dev"
    },
   "[summit-score-growth-study-prd]" = {
	   FunctionName = "summit-score-growth-study-prd"
    },
   "[summit-score-growth-study-stg]" = {
	   FunctionName = "summit-score-growth-study-stg"
    },
  #  "[summit-score-push-prd]" = {
	#    FunctionName = "summit-score-push-prd"
  #   },
   "[summit-score-push-preprd]" = {
	   FunctionName = "summit-score-push-preprd"
    },
   "[summit-score-push-stg]" = {
	   FunctionName = "summit-score-push-stg"
    },
   "[summit-score-scm-push-prd]" = {
	   FunctionName = "summit-score-scm-push-prd"
    },
   "[summit-score-scm-push-preprd]" = {
	   FunctionName = "summit-score-scm-push-preprd"
    },
   "[summit-score-scm-push-stg]" = {
	   FunctionName = "summit-score-scm-push-stg"
    },
   "[summit-score-scm-replay-prd]" = {
	   FunctionName = "summit-score-scm-replay-prd"
    },
   "[summit-score-slack-mgt]" = {
	   FunctionName = "summit-score-slack-mgt"
    },
   "[trinity-learning-event-sourcing-dev]" = {
	   FunctionName = "trinity-learning-event-sourcing-dev"
    },
   "[trinity-learning-event-sourcing-prd]" = {
	   FunctionName = "trinity-learning-event-sourcing-prd"
    },
   "[trinity-learning-event-sourcing-stg]" = {
	   FunctionName = "trinity-learning-event-sourcing-stg"
    }
  }

  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  # threshold_warn           = 0
  # ok_actions_warn          = false
  # alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit           = 100
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
}

