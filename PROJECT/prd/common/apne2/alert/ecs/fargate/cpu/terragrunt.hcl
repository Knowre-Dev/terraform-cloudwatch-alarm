terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_common" {
  config_path = "../../../../sns/alarm-to-slack/common"
}

inputs = {
  alarm_name          = "Fargate CPU Usage"
  alarm_description   = "Fargate CPU Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"

  dimensions = {
    "[hexagon]"     = {
      ClusterName: "hexagon"
      ServiceName: "hexagon-strapi-mgt"
    },
    "[mowbore]"     = {
      ClusterName: "mowbore"
      ServiceName: "mowbore-sl-stable"
    },
    "[mowbore-dump-worker]"     = {
      ClusterName: "mowbore"
      ServiceName: "mowbore-dump-worker-stable"
    },
    "[knowre-school-auth]"     = {
      ClusterName: "knowre-school"
      ServiceName: "knowre-school-auth-prd"
    },
    "[knowre-school-lms]"     = {
      ClusterName: "knowre-school"
      ServiceName: "knowre-school-lms-prd"
    },
    "[jarvis-payment]"     = {
      ClusterName: "jarvis"
      ServiceName: "jarvis-payment-prd"
    },
    "[jarvis-auth]"     = {
      ClusterName: "jarvis"
      ServiceName: "jarvis-auth-prd"
    },
    "[jarvis-learning]"     = {
      ClusterName: "jarvis"
      ServiceName: "jarvis-learning-prd"
    },
    "[krdky]"     = {
      ClusterName: "krdky"
      ServiceName: "krdky-stable"
    },
    "[kraims]"     = {
      ClusterName: "kraims"
      ServiceName: "kraims-stable"
    },
    "[krsqr]"     = {
      ClusterName: "krsqr"
      ServiceName: "krsqr-stable"
    },
    "[locian0kr]"     = {
      ClusterName: "locian0kr"
      ServiceName: "locian0kr-stable"
    },
    "[trinity-diagnostic-rest]"     = {
      ClusterName: "trinity"
      ServiceName: "trinity-diagnostic-rest-prd"
    },
    "[trinity-learning-query-rest]"     = {
      ClusterName: "trinity"
      ServiceName: "trinity-learning-query-rest-prd"
    },
    "[glacl-kr]"     = {
      ClusterName: "glacl-kr"
      ServiceName: "glacl-kr-stable"
    },
    "[krschool]"     = {
      ClusterName: "krschool"
      ServiceName: "knowre-school-stable"
    },
    "[school-trinity-learning-query-rest]"     = {
      ClusterName: "trinity"
      ServiceName: "school-trinity-learning-query-rest-prd"
    }
  }

  threshold_crit      = 90
  ok_actions_crit     = true
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}