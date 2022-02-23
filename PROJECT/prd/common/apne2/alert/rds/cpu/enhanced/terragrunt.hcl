terraform {
  source = "../../../../../../../../SERVICE/terraform-service-aws-cloudwatch-alert/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_db" {
  config_path = "../../../../sns/alarm-to-slack/db"
}

inputs = {
  alarm_name        = "RDS CPU Usage"
  alarm_description = "RDS CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 10
  datapoints_to_alarm = 1

  cw_namespace   = "AWS/RDS"
  metric_name = "CPUUtilization"
  statistic   = "Maximum"

  # dimensions = var.dimensions
  dimensions = {
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "knowre-lms-devopsms985-cluster"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "kr-dky-red-devopsms974"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-acl-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-adm-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-aims-red-u"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-datcntr-pgsql-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-dky-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-grafana-red-mgt"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-hexagon-cms-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-hexagon-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-hexagon-strapi-red-mgt"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-jarvis-auth-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-jarvis-learning-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-jarvis-payment-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-knowre-school-auth-red-prd"
    },
     "[knowre-lms-devopsms985-cluster]" = {
     "DBClusterIdentifier" = "sl-knowre-school-lms-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-lc0-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-lc2ccms-red-mgt"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-lc2csrv-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-mbr-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-mngment-red-mgt"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-sqr-red-s"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-summit-score-admin-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-trinity-diagnostic-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-trinity-league-red-prd"
    },
    "[knowre-lms-devopsms985-cluster]" = {
      "DBClusterIdentifier" = "sl-usp-red-d"
    }
  }
  
  threshold_warn           = 50
  ok_actions_warn          = true
  alarm_actions_warn       = [dependency.sns_topic_db.outputs.sns_topic_arn]

  threshold_crit           = 65
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_db.outputs.sns_topic_arn]
}