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
  alarm_name          = "Fargate Memory Usage"
  alarm_description   = "Fargate Memory Usage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 3
  unit                = "Percent"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ECS"
  metric_name         = "MemoryUtilization"
  statistic           = "Maximum"

  dimensions = {
    "[hexagon]"     = {
      ClusterName: "hexagon"
      ServiceName: "hexagon-strapi-mgt"
    },
    # "[mowbore]"     = {
    #   ClusterName: "mowbore"
    #   ServiceName: "mowbore-sl-stable"
    # },
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
    "[krdky]"     = {
      ClusterName: "krdky"
      ServiceName: "krdky-stable"
    },
    "[locian0kr]"     = {
      ClusterName: "locian0kr"
      ServiceName: "locian0kr-stable"
    },
    "[trinity-learning-query-rest]"     = {
      ClusterName: "trinity"
      ServiceName: "trinity-learning-query-rest-prd"
    },
    "[krschool]"     = {
      ClusterName: "krschool"
      ServiceName: "knowre-school-stable"
    },
    "[school-trinity-learning-query-rest]"     = {
      ClusterName: "trinity"
      ServiceName: "school-trinity-learning-query-rest-prd"
    },
    "[prd-apne2-kr-hexagon]"     = {
      ClusterName: "prd-apne2-kr-hexagon-ecs-cluster"
      ServiceName: "prd-apne2-kr-hexagon"
    },
    "[prd-apne2-kr-summit-score-dreams-xapi"     = {
      ClusterName: "prd-apne2-kr-summit-score-dreams-xapi"
      ServiceName: "prd-apne2-kr-summit-score-dreams-xapi"
    }
  }

  threshold_warn      = 70
  ok_actions_warn     = true
  alarm_actions_warn  = [dependency.sns_topic_common.outputs.sns_topic_arn]

  threshold_crit      = 90
  ok_actions_crit     = false
  alarm_actions_crit  = [dependency.sns_topic_common.outputs.sns_topic_arn]
}