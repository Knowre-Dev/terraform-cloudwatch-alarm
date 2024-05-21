terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/generic_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../sns/alertnow/summit-score/topic"
}

inputs = {
  alarm_name          = "[AlertNow] REDIS Memory Usage [SummitScore]"
  alarm_description   = "[AlertNow] REDIS Memory Usage [SummitScore]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ElastiCache"
  metric_name         = "DatabaseMemoryUsagePercentage"
  statistic           = "Maximum"

  dimensions = {
    "[CMS-CACHE-001]" = {
      CacheClusterId: "sl-dky-navy-prd-001"
    },
    "[CMS-CACHE-002]" = {
      CacheClusterId: "sl-dky-navy-prd-002"
    },
    "[LearningHistory-CACHE-001]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-001"
    },
    "[LearningHistory-CACHE-002]" = {
      CacheClusterId: "sl-trinity-answer-navy-prd-002"
    }
  }

  threshold_warn           = 60
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic.outputs.sns_topic_arn]

  threshold_crit           = 70
  ok_actions_crit          = true
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}