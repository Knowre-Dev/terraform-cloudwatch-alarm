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
    "[mgt-apne2-kr-hexagon-strapi-aurora-cluster]" = {
      DBClusterIdentifier = "mgt-apne2-kr-hexagon-strapi-aurora-cluster"
    },
    "[mgt-apne2-kr-management-aurora-cluster]" = {
      DBClusterIdentifier = "mgt-apne2-kr-management-aurora-cluster"
    },
    "[prd-apne2-kr-hexagon-cms-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-hexagon-cms-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-auth-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-auth-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-lms-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-lms-aurora-cluster"
    }
  }

  threshold_warn           = 1073741824 # 1GB
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 629145600 # 600MB
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}