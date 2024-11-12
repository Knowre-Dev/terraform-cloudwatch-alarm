terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../sns/alarm-to-slack/db"
}

inputs = {
  alarm_name          = "RDS Freeable Memory"
  alarm_description   = "RDS Freeable Memory"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1

  unit                = "Bytes"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/RDS"
  metric_name         = "FreeableMemory"
  statistic           = "Minimum"

  # dimensions = var.dimensions
  dimensions = {
    "[prd-usea1-us-locian-aurora-cluster]" = {
      DBClusterIdentifier = "prd-usea1-us-locian-aurora-cluster"
    }
  }

  threshold_warn           = 734003200 # 700MB
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 629145600 # 600MB
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}