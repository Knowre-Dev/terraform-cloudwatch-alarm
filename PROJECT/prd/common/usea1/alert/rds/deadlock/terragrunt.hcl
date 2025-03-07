terraform {
  source = "../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../sns/alarm-to-slack/db"
}

inputs = {
  alarm_name        = "RDS Deadlock"
  alarm_description = "RDS Deadlock"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  # unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace   = "AWS/RDS"
  metric_name = "Deadlocks"
  statistic   = "Maximum"

  dimensions = {
    "[prd-usea1-us-locian-aurora-cluster]" = {
      DBClusterIdentifier = "prd-usea1-us-locian-aurora-cluster"
    },
    "[prd-usea1-us-school-plus-aurora-cluster]" = {
      DBClusterIdentifier = "prd-usea1-us-school-plus-aurora-cluster-cluster"
    }
  }

  threshold_warn           = 10
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 20
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}