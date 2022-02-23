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
  alarm_name          = "Lambda Throttles"
  alarm_description   = "Lambda Throttles"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/Lambda"
  metric_name         = "Throttles"
  statistic           = "Sum"

  dimensions = {
    "[network-monitor-client-sl-private1]]" = {
      FunctionName = "network-monitor-client-sl-private1"
    },
    "[summit-score-admin-prd]" = {
      FunctionName = "summit-score-admin-prd"
    },
    "[summit-score-growth-study-prd]" = {
      FunctionName = "summit-score-growth-study-prd"
    },
    "[hexagon-external-api-prd]" = {
      FunctionName = "hexagon-external-api-prd"
    },
    "[summit-score-scm-push-prd]" = {
      FunctionName = "summit-score-scm-push-prd"
    },
    "[validation-request]" = {
      FunctionName = "validation-request"
    },
    "[locian2-csrv-api-prd]" = {
      FunctionName = "locian2-csrv-api-prd"
    },
    "[management-oauth]" = {
      FunctionName = "management-oauth"
    },
    # "[datacentral-glue-event-watcher-dev]" = {
    #   FunctionName = "datacentral-glue-event-watcher-dev"
    # },
    # "[datacentral-stream-cwl-stg-04-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-stg-04-sl"
    # },
    # "[trinity-learning-event-sourcing-dev]" = {
    #   FunctionName = "trinity-learning-event-sourcing-dev"
    # },
    # "[sns-send-email-test]" = {
    #   FunctionName = "sns-send-email-test"
    # },
    # "[datacentral-stream-cwl-stg-03-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-stg-03-sl"
    # },
    "[summit-score-push-prd]" = {
      FunctionName = "summit-score-push-prd"
    },
    # "[datacentral-lambda-stg]" = {
    #   FunctionName = "datacentral-lambda-stg"
    # },
    "[codebuild-noti]" = {
      FunctionName = "codebuild-noti"
    },
    # "[datacentral-stream-cwl-dev-01-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-dev-01-sl"
    # },
    "[datacentral-stream-cwl-prd-01-sl]" = {
      FunctionName = "datacentral-stream-cwl-prd-01-sl"
    },
    "[scheduler-hexagon-batch]" = {
      FunctionName = "scheduler-hexagon-batch"
    },
    "[network-monitor-client-sl-public2]" = {
      FunctionName = "network-monitor-client-sl-public2"
    },
    # "[marketing-kr-dev]" = {
    #   FunctionName = "marketing-kr-dev"
    # },
    "[locian2-ccms-graphql]" = {
      FunctionName = "locian2-ccms-graphql"
    },
    "[scheduler-scale-task]" = {
      FunctionName = "scheduler-scale-task"
    },
    # "[datacentral-lambda-dev]" = {
    #   FunctionName = "datacentral-lambda-dev"
    # },
    # "[summit-score-extra-stg]" = {
    #   FunctionName = "summit-score-extra-stg"
    # },
    # "[cmlops-test]" = {
    #   FunctionName = "cmlops-test"
    # },
    # "[datacentral-stream-cwl-stg-01-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-stg-01-sl"
    # },
    # "[datacentral-stream-cwl-stg-02-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-stg-02-sl"
    # },
    "[network-monitor-server-sl-public2]" = {
      FunctionName = "network-monitor-server-sl-public2"
    },
    # "[summit-score-growth-study-stg]" = {
    #   FunctionName = "summit-score-growth-study-stg"
    # },
    "[ECSEventsLogsToCloudWatch]" = {
      FunctionName = "ECSEventsLogsToCloudWatch"
    },
    # "[summit-score-scm-push-dev]" = {
    #   FunctionName = "summit-score-scm-push-dev"
    # },
    # "[hexagon-api-dev]" = {
    #   FunctionName = "hexagon-api-dev"
    # },
    "[network-monitor-server-sl-public1]" = {
      FunctionName = "network-monitor-server-sl-public1"
    },
    "[codebuild-webhook]" = {
      FunctionName = "codebuild-webhook"
    },
    # "[summit-score-scm-replay-stg]" = {
    #   FunctionName = "summit-score-scm-replay-stg"
    # },
    "[summit-score-slack-mgt]" = {
      FunctionName = "summit-score-slack-mgt"
    },
    "[locian2-ucms-graphql]" = {
      FunctionName = "locian2-ucms-graphql"
    },
    # "[locian-rest-dev]" = {
    #   FunctionName = "locian-rest-dev"
    # },
    # "[summit-score-push-stg]" = {
    #   FunctionName = "summit-score-push-stg"
    # },
    "[scheduler-url-call]" = {
      FunctionName = "scheduler-url-call"
    },
    # "[datacentral-glue-event-watcher-stg]" = {
    #   FunctionName = "datacentral-glue-event-watcher-stg"
    # },
    # "[summit-score-contentsqa-dev]" = {
    #   FunctionName = "summit-score-contentsqa-dev"
    # },
    "[network-monitor-server-sl-private1]" = {
      FunctionName = "network-monitor-server-sl-private1"
    },
    "[datacentral-stream-cwl-prd-02-sl]" = {
      FunctionName = "datacentral-stream-cwl-prd-02-sl"
    },
    "[summit-score-scm-replay-prd]" = {
      FunctionName = "summit-score-scm-replay-prd"
    },
    "[network-monitor-client-sl-public1]" = {
      FunctionName = "network-monitor-client-sl-public1"
    },
    "[scheduler-invalidation-cloudfront]" = {
      FunctionName = "scheduler-invalidation-cloudfront"
    },
    "[scheduler-deps-mgmt]" = {
      FunctionName = "scheduler-deps-mgmt"
    },
    "[datacentral-lambda-prd-sl]" = {
      FunctionName = "datacentral-lambda-prd-sl"
    },
    # "[marketing-kr-stg]" = {
    #   FunctionName = "marketing-kr-stg"
    # },
    # "[summit-score-admin-dev]" = {
    #   FunctionName = "summit-score-admin-dev"
    # },
    # "[datacentral-stream-cwl-dev-03-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-dev-03-sl"
    # },
    "[scheduler-docker-task]" = {
      FunctionName = "scheduler-docker-task"
    },
    # "[datacentral-metric-api-graphql-dev]" = {
    #   FunctionName = "datacentral-metric-api-graphql-dev"
    # },
    "[hexagon-api-prd]" = {
      FunctionName = "hexagon-api-prd"
    },
    # "[datacentral-metric-api-graphql-stg]" = {
    #   FunctionName = "datacentral-metric-api-graphql-stg"
    # },
    "[datacentral-stream-cwl-prd-04-sl]" = {
      FunctionName = "datacentral-stream-cwl-prd-04-sl"
    },
    # "[hexagon-external-api-dev]" = {
    #   FunctionName = "hexagon-external-api-dev"
    # },
    "[datacentral-metric-api-graphql-prd-sl]" = {
      FunctionName = "datacentral-metric-api-graphql-prd-sl"
    },
    # "[summit-score-admin-stg]" = {
    #   FunctionName = "summit-score-admin-stg"
    # },
    "[email-sender-node]" = {
      FunctionName = "email-sender-node"
    },
    "[email-sender]" = {
      FunctionName = "email-sender"
    },
    # "[summit-score-scm-push-stg]" = {
    #   FunctionName = "summit-score-scm-push-stg"
    # },
    # "[hexagon-external-api-stg]" = {
    #   FunctionName = "hexagon-external-api-stg"
    # },
    # "[summit-score-growth-study-dev]" = {
    #   FunctionName = "summit-score-growth-study-dev"
    # },
    "[scheduler-dead-mans-switch]" = {
      FunctionName = "scheduler-dead-mans-switch"
    },
    # "[us-school-plus-graphql-dev]" = {
    #   FunctionName = "us-school-plus-graphql-dev"
    # },
    # "[locian2-csrv-api-dev]" = {
    #   FunctionName = "locian2-csrv-api-dev"
    # },
    # "[summit-score-scm-replay-dev]" = {
    #   FunctionName = "summit-score-scm-replay-dev"
    # },
    # "[trinity-learning-event-sourcing-stg]" = {
    #   FunctionName = "trinity-learning-event-sourcing-stg"
    # },
    # "[locian2-csrv-api-stg]" = {
    #   FunctionName = "locian2-csrv-api-stg"
    # },
    # "[trinity-league-rest-stg]" = {
    #   FunctionName = "trinity-league-rest-stg"
    # },
    "[scheduler-recreate-branch]" = {
      FunctionName = "scheduler-recreate-branch"
    },
    "[datacentral-glue-event-watcher-prd-sl]" = {
       FunctionName = "datacentral-glue-event-watcher-prd-sl"
    },
    # "[summit-score-extra-dev]" = {
    #    FunctionName = "summit-score-extra-dev"
    # },
    # "[summit-score-push-dev]" = {
    #   FunctionName = "summit-score-push-dev"
    # },
    "[marketing-kr-prd]" = {
      FunctionName = "marketing-kr-prd"
    },
    "[management-build-log]" = {
      FunctionName = "management-build-log"
    },
    "[scheduler-autopause-aurora]" = {
      FunctionName = "scheduler-autopause-aurora"
    },
    # "[summit-score-tts-dev]" = {
    #   FunctionName = "summit-score-tts-dev"
    # },
    "[summit-score-extra-prd]" = {
      FunctionName = "summit-score-extra-prd"
    },
    "[summit-score-tts-prd]" = {
      FunctionName = "summit-score-tts-prd"
    },
    "[datacentral-stream-cwl-dev-02-sl]" = {
      FunctionName = "datacentral-stream-cwl-dev-02-sl"
    },
    "[trinity-learning-event-sourcing-prd]" = {
      FunctionName = "trinity-learning-event-sourcing-prd"
    },
    # "[trinity-league-rest-dev]" = {
    #   FunctionName = "trinity-league-rest-dev"
    # },
    # "[us-school-plus-oauth-dev]" = {
    #   FunctionName = "us-school-plus-oauth-dev"
    # },
    "[network-monitor-client-sl-private2]" = {
      FunctionName = "network-monitor-client-sl-private2"
    },
    "[network-monitor-server-sl-private2]" = {
      FunctionName = "network-monitor-server-sl-private2"
    },
    # "[datacentral-stream-cwl-dev-04-sl]" = {
    #   FunctionName = "datacentral-stream-cwl-dev-04-sl"
    # },
    "[scheduler-merge-branch]" = {
      FunctionName = "scheduler-merge-branch"
    },
    "[scheduler-scale-aurora]" = {
      FunctionName = "scheduler-scale-aurora"
    },
    "[sns-event-noti]" = {
      FunctionName = "sns-event-noti"
    },
    "[scheduler-bardeg]" = {
      FunctionName = "scheduler-bardeg"
    },
    "[datacentral-stream-cwl-prd-03-sl]" = {
      FunctionName = "datacentral-stream-cwl-prd-03-sl"
    },
    # "[hexagon-api-stg]" = {
    #   FunctionName = "hexagon-api-stg"
    # },
    "[management-graphql]" = {
      FunctionName = "management-graphql"
    },
    # "[summit-score-tts-stg]" = {
    #   FunctionName = "summit-score-tts-stg"
    # },
    "[trinity-league-rest-prd]" = {
      FunctionName = "trinity-league-rest-prd"
    }
  }

  # threshold_info           = 0
  # ok_actions_info          = false
  # alarm_actions_info       = []
  
  # threshold_warn           = 0
  # ok_actions_warn          = false
  # alarm_actions_warn       = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit           = 2
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_common.outputs.sns_topic_arn]
}

