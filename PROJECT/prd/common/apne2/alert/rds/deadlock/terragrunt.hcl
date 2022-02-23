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
    "[knowre-lms-devopsms985-cluster]" = {
      DBClusterIdentifier = "knowre-lms-devopsms985-cluster"
    },
    "[kr-dky-red-devopsms974]" = {
      DBClusterIdentifier = "kr-dky-red-devopsms974"
    },
    "[sl-acl-red-s]" = {
      DBClusterIdentifier = "sl-acl-red-s"
    },
    "[sl-adm-red-s]" = {
      DBClusterIdentifier = "sl-adm-red-s"
    },
    "[sl-aims-red-u]" = {
      DBClusterIdentifier = "sl-aims-red-u"
    },
    "[sl-datcntr-pgsql-prd]" = {
      DBClusterIdentifier = "sl-datcntr-pgsql-prd"
    },
    "[sl-dky-red-s]" = {
      DBClusterIdentifier = "sl-dky-red-s"
    },
    "[sl-grafana-red-mgt]" = {
      DBClusterIdentifier = "sl-grafana-red-mgt"
    },
    "[sl-hexagon-cms-prd]" = {
      DBClusterIdentifier = "sl-hexagon-cms-prd"
    },
    "[sl-hexagon-red-prd]" = {
      DBClusterIdentifier = "sl-hexagon-red-prd"
    },
    "[sl-hexagon-strapi-red-mgt]" = {
      DBClusterIdentifier = "sl-hexagon-strapi-red-mgt"
    },
    "[sl-jarvis-auth-red-prd]" = {
      DBClusterIdentifier = "sl-jarvis-auth-red-prd"
    },
    "[sl-jarvis-learning-red-prd]" = {
      DBClusterIdentifier = "sl-jarvis-learning-red-prd"
    },
    "[sl-jarvis-payment-red-prd]" = {
      DBClusterIdentifier = "sl-jarvis-payment-red-prd"
    },
    "[sl-knowre-school-auth-red-prd]" = {
      DBClusterIdentifier = "sl-knowre-school-auth-red-prd"
    },
     "[sl-knowre-school-lms-red-prd]" = {
     DBClusterIdentifier = "sl-knowre-school-lms-red-prd"
    },
    "[sl-lc0-red-s]" = {
      DBClusterIdentifier = "sl-lc0-red-s"
    },
    "[sl-lc2ccms-red-mgt]" = {
      DBClusterIdentifier = "sl-lc2ccms-red-mgt"
    },
    "[sl-lc2csrv-red-prd]" = {
      DBClusterIdentifier = "sl-lc2csrv-red-prd"
    },
    "[sl-mbr-red-s]" = {
      DBClusterIdentifier = "sl-mbr-red-s"
    },
    "[sl-mngment-red-mgt]" = {
      DBClusterIdentifier = "sl-mngment-red-mgt"
    },
    "[sl-sqr-red-s]" = {
      DBClusterIdentifier = "sl-sqr-red-s"
    },
    "[sl-summit-score-admin-red-prd]" = {
      DBClusterIdentifier = "sl-summit-score-admin-red-prd"
    },
    "[sl-trinity-diagnostic-red-prd]" = {
      DBClusterIdentifier = "sl-trinity-diagnostic-red-prd"
    },
    "[sl-trinity-league-red-prd]" = {
      DBClusterIdentifier = "sl-trinity-league-red-prd"
    },
    "[sl-usp-red-d]" = {
      DBClusterIdentifier = "sl-usp-red-d"
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