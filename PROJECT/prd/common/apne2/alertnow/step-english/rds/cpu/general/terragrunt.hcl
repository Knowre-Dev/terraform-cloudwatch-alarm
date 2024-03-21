terraform {
  source = "git::ssh://git@github.com/Knowre-Dev/terraform-service-repo.git//cloudwatch/metric/alarm/generic_multiple_dimension?ref=main"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic" {
  config_path = "../../../../../sns/alertnow/step-english/topic"
}

inputs = {
  alarm_name          = "[AlertNow] RDS CPU Usage [StepEnglish]"
  alarm_description   = "[AlertNow] RDS CPU Usage [StepEnglish]"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/RDS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"

  # dimensions = var.dimensions
  dimensions = {
    "[MAIN]" = {
      DBClusterIdentifier = "prd-apne2-kr-hexagon-aurora-cluster"
    }
  }

  threshold_warn           = 50
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic.outputs.sns_topic_arn]

  threshold_crit           = 65
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}