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
  alarm_name          = "RDS CPU Usage"
  alarm_description   = "RDS CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1

  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/RDS"
  metric_name         = "CPUUtilization"
  statistic           = "Maximum"

  # dimensions = var.dimensions
  dimensions = {
    "[prd-apne2-kr-hexagon-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-hexagon-aurora-cluster"
    },
    "[prd-apne2-kr-hexagon-cms-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-hexagon-cms-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-auth-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-auth-aurora-cluster"
    },
    "[prd-apne2-kr-knowre-school-lms-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-knowre-school-lms-aurora-cluster"
    },
    "[prd-apne2-kr-locian-blue-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-locian-blue-aurora-cluster"
    },
     "[prd-apne2-kr-mowbore-aurora-cluster]" = {
     DBClusterIdentifier = "prd-apne2-kr-mowbore-aurora-cluster"
    },
    "[prd-apne2-kr-summit-score-aurora-cluster]" = {
      DBClusterIdentifier = "prd-apne2-kr-summit-score-aurora-cluster"
    }
    # "[preprd-apne2-kr-hexagon-aurora-cluster]" = {
    #   DBClusterIdentifier = "preprd-apne2-kr-hexagon-aurora-cluster"
    # }
  }

  threshold_warn           = 50
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 65
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}