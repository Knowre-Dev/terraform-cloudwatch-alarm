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
  alarm_name          = "RDS Free Memory"
  alarm_description   = "RDS Free Memory"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1

  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/RDS"
  metric_name         = "FreeableMemory"
  statistic           = "Minimum"

  # dimensions = var.dimensions
  dimensions = {
    "[prd-apne2-kr-hexagon-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-hexagon-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-aurora-cluster"
    },
    "[prd-apne2-kr-locian-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-locian-aurora-cluster"
    },
    "[prd-apne2-kr-mowbore-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-mowbore-aurora-cluster"
    },
    "[prd-apne2-kr-summit-score-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-summit-score-aurora-cluster"
    }
  }

  threshold_warn           = 2147483648 # 2GB
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 1073741824 # 1GB
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}