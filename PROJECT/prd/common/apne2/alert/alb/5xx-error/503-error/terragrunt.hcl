terraform {
  source = "../../../../../../../../SERVICE/cloudwatch/metric/alarm/generic_multiple_dimension"
}

include {
  path = "${find_in_parent_folders()}"
}

dependency "sns_topic_server" {
  config_path         = "../../../../sns/alarm-to-slack/server"
}

inputs = {
  alarm_name          = "503 Server Error"
  alarm_description   = "503 Server Error"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  unit                = "Count"
  period              = 60
  datapoints_to_alarm = 1

  cw_namespace        = "AWS/ApplicationELB"
  metric_name         = "HTTPCode_ELB_503_Count"
  statistic           = "Sum"

  # dimensions = var.dimensions
  dimensions = {
    # "[dky]" = {
    #   LoadBalancer = "app/dky-stable/2fbfb438da5302a7"
    # },
    "[locaian0kr]" = {
      LoadBalancer = "app/locian0kr-stable/5118b11b02a7dad9"
    },
    # "[glacl-kr]" = {
    #   LoadBalancer = "app/glacl-kr-stable/df4550d6e9e8bfdf"
    # },
    # "[krsqr]" = {
    #   LoadBalancer = "app/krsqr-stable/17b1563bfe7f7b1a"
    # },
    "[mowbore-sl]" = {
      LoadBalancer = "app/mowbore-sl-stable/875688c2a52379f9"
    }
    "[mowbore-dump-worker]" = {
      LoadBalancer = "app/mowbore-dump-worker-stable/b3f70a9a8b338b19"
    },
    "[knowre-school-lms]" = {
      LoadBalancer = "app/knowre-school-lms-prd/a20e67095faf6ea8"
    },
    "[trinity-learning-query-rest]" = {
      LoadBalancer = "app/trinity-learning-query-rest-prd/cd05403944090cae"
    },
    "[knowre-school-auth]" = {
      LoadBalancer = "app/knowre-school-auth-prd/326a5c32379c310b"
    },
    # "[trinity-diagnostic-rest]" = {
    #   LoadBalancer = "app/trinity-diagnostic-rest-prd/0aa864ca88cfee0b"
    # },
    # "[jarvis-auth]" = {
    #   LoadBalancer = "app/jarvis-auth-prd/15199c16c54403f0"
    # },
    # "[jarvis-payment]" = {
    #   LoadBalancer = "app/jarvis-payment-prd/bc2dc0435a3914a2"
    # },
    # "[jarvis-learning]" = {
    #   LoadBalancer = "app/jarvis-learning-prd/f1c7dc12242fb662"
    # },
    "[school-trinity-learning-query-rest]" = {
      LoadBalancer = "app/schoolTrinityLearningQueryPrd/b44568c21819cbb9"
    },
    "[prd-apne2-kr-hexagon]" = {
      LoadBalancer = "app/prd-apne2-kr-hexagon-alb/a8a724c5e829860f"
    }
  }

  enable_crit              = true
  threshold_crit           = 1
  ok_actions_crit          = false
  alarm_actions_crit       = [dependency.sns_topic_server.outputs.sns_topic_arn]
  # extended_statistic = var.extended_statistic
}

